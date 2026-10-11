#!/usr/bin/env python3
"""Render AniEye Play Store graphics as HTML mockups, screenshotted with
headless Chrome. No third-party Python deps.

Writes:
  <app>/store_assets/graphics/feature_graphic_1024x500.png
  <app>/store_assets/screenshots/01..05_*.png            (1080x1920)

Usage:
  python3 make_graphics.py [app_root]
"""
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

APP_ROOT = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else Path.cwd()
GRAPHICS = APP_ROOT / "store_assets" / "graphics"
SHOTS = APP_ROOT / "store_assets" / "screenshots"
for d in (GRAPHICS, SHOTS):
    d.mkdir(parents=True, exist_ok=True)

CHROME = (shutil.which("google-chrome-stable") or shutil.which("google-chrome")
          or shutil.which("brave") or shutil.which("chromium"))

CSS = """
*{margin:0;padding:0;box-sizing:border-box;-webkit-font-smoothing:antialiased}
body{font-family:'DejaVu Sans','Segoe UI',Roboto,sans-serif;background:#0A0F1E;color:#EDF1FB}
.screen{width:1080px;height:1920px;position:relative;display:flex;flex-direction:column;overflow:hidden}
.status{display:flex;justify-content:space-between;font-size:28px;color:#93A0C0;padding:24px 40px 0}
.hdr{display:flex;align-items:center;gap:18px;padding:18px 44px 12px}
.logo{width:72px;height:72px;display:flex;align-items:center;justify-content:center}
.word{font-size:44px;font-weight:800;letter-spacing:-1px}
.word small{display:block;font-size:22px;font-weight:500;color:#93A0C0;letter-spacing:0}
.chip{margin-left:auto;display:flex;align-items:center;gap:10px;background:#131C31;border:2px solid #27314F;border-radius:40px;padding:14px 24px;font-size:24px;color:#93A0C0;font-weight:600}
.chip .d{color:#2FD4C4}
.search{margin:4px 44px 10px;background:#131C31;border:2px solid #27314F;border-radius:18px;padding:22px 26px;color:#93A0C0;font-size:28px}
.meta{display:flex;justify-content:space-between;padding:6px 48px;color:#93A0C0;font-size:27px;font-weight:600}
.pill{display:inline-block;background:rgba(47,212,196,.14);color:#2FD4C4;border:2px solid rgba(47,212,196,.4);border-radius:20px;padding:10px 22px;font-size:24px;font-weight:700}
.row{display:flex;gap:24px;padding:26px 44px;border-bottom:2px solid #16203a;align-items:center}
.ric{width:92px;height:92px;border-radius:22px;display:flex;align-items:center;justify-content:center;font-size:44px;flex:0 0 auto}
.rt{font-size:34px;font-weight:800}
.rs{color:#93A0C0;font-size:25px;margin-top:6px}
.chev{margin-left:auto;color:#93A0C0;font-size:40px}
.card{margin:18px 44px 0;padding:40px;border-radius:28px;background:linear-gradient(135deg,rgba(91,124,255,.24),rgba(47,212,196,.16));border:2px solid rgba(91,124,255,.45)}
.cardh{display:flex;justify-content:space-between;margin-bottom:20px}
.title{font-size:48px;font-weight:900;line-height:1.15}
.sub{color:#93A0C0;font-size:28px;margin-top:8px}
.blurb{font-size:30px;line-height:1.5;margin-top:20px}
.sect{color:#7A86A8;font-size:22px;font-weight:800;letter-spacing:3px;margin:26px 48px 8px}
.step{display:flex;gap:26px;padding:0 44px;margin-bottom:6px}
.badge{width:78px;height:78px;border-radius:50%;background:linear-gradient(135deg,#5B7CFF,#2FD4C4);display:flex;align-items:center;justify-content:center;font-size:34px;font-weight:900;color:#fff;flex:0 0 auto}
.badge.opt{background:#1B2740;border:2px solid #27314F;color:#93A0C0}
.linewrap{flex:1;padding-bottom:26px;border-left:0 solid #27314F}
.stept{font-size:34px;font-weight:800}
.stepn{color:#93A0C0;font-size:26px;margin-top:6px;line-height:1.4}
.opttag{display:inline-block;background:#1B2740;color:#93A0C0;border:2px solid #27314F;border-radius:16px;padding:6px 16px;font-size:22px;font-weight:700;margin-left:12px}
.note{margin:24px 44px 0;background:#1B2740;border-radius:18px;padding:26px;color:#A9B4D0;font-size:27px;line-height:1.45}
.nav{position:absolute;left:0;right:0;bottom:0;height:150px;background:#080C17;border-top:2px solid #16203a;display:flex;align-items:center;justify-content:space-around;padding-bottom:14px}
.nav .it{display:flex;flex-direction:column;align-items:center;gap:8px;color:#6F7DA0;font-size:20px}
.nav .it.on{color:#2FD4C4}
.nav .ic{width:56px;height:56px;border-radius:16px;background:#141d33;display:flex;align-items:center;justify-content:center;font-size:30px}
.nav .on .ic{background:rgba(47,212,196,.18)}
.feature{width:1024px;height:500px;background:radial-gradient(120% 160% at 15% 10%,#12204A 0%,#0A0F1E 55%,#06080F 100%);position:relative;overflow:hidden;display:flex;align-items:center;padding:0 70px}
.fglow{position:absolute;right:-120px;top:-140px;width:560px;height:560px;border-radius:50%;background:radial-gradient(circle,rgba(91,124,255,.55),transparent 62%)}
.fglow2{position:absolute;right:120px;bottom:-220px;width:520px;height:520px;border-radius:50%;background:radial-gradient(circle,rgba(47,212,196,.4),transparent 62%)}
.fleft{z-index:2;display:flex;align-items:center;gap:34px}
.flogo{display:flex;align-items:center;justify-content:center;box-shadow:0 30px 70px rgba(91,124,255,.5);border-radius:46px}
.fname{font-size:88px;font-weight:900;letter-spacing:-3px}
.ftag{font-size:34px;color:#C3CEE8;margin-top:6px}
.fbadges{display:flex;gap:14px;margin-top:24px}
.fb{font-size:26px;font-weight:800;border-radius:16px;padding:12px 22px}
.fb1{color:#5B7CFF;background:rgba(91,124,255,.16);border:2px solid rgba(91,124,255,.5)}
.fb2{color:#2FD4C4;background:rgba(47,212,196,.14);border:2px solid rgba(47,212,196,.45)}
.fb3{color:#FFC24B;background:rgba(255,194,75,.13);border:2px solid rgba(255,194,75,.4)}
"""


def render_html(html, out, w, h):
    if CHROME is None:
        print("No Chrome found; skipping", out.name)
        return
    with tempfile.NamedTemporaryFile("w", suffix=".html", delete=False) as f:
        f.write(html)
        path = f.name
    subprocess.run(
        [CHROME, "--headless=new", "--no-sandbox", "--disable-gpu",
         "--hide-scrollbars", "--force-device-scale-factor=1",
         f"--window-size={w},{h}", f"--screenshot={out}", f"file://{path}"],
        check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
    )
    Path(path).unlink(missing_ok=True)
    print(f"  {out.relative_to(APP_ROOT)}")


def page(body, w, h):
    return (f"<!DOCTYPE html><html><head><meta charset='utf-8'><style>"
            f"{CSS}\nhtml,body{{width:{w}px;height:{h}px}}</style></head>"
            f"<body>{body}</body></html>")


# Inline SVG mark matching the app icon (gradient eye + play pupil).
def logomark(size):
    return (
        f"<svg width='{size}' height='{size}' viewBox='0 0 100 100'>"
        "<defs><linearGradient id='g' x1='0' y1='0' x2='1' y2='1'>"
        "<stop offset='0' stop-color='#5B7CFF'/><stop offset='1' stop-color='#2FD4C4'/>"
        "</linearGradient></defs>"
        "<rect x='0' y='0' width='100' height='100' rx='26' fill='#0A0F1E'/>"
        "<path d='M14 50 Q50 15 86 50 Q50 85 14 50 Z' fill='none' "
        "stroke='url(#g)' stroke-width='8'/>"
        "<path d='M43 36 L43 64 L68 50 Z' fill='url(#g)'/>"
        "</svg>"
    )


def status():
    return "<div class='status'><span>9:41</span><span>&#9679; &#9679; &#9679; &#9679;</span></div>"


def header():
    return ("<div class='hdr'><div class='logo'>" + logomark(72) + "</div>"
            "<div class='word'>AniEye<small>Anime Watch-Order Helper</small></div>"
            "<div class='chip'><span class='d'>&#10003;</span> Offline</div></div>")


def nav(active):
    items = [("&#9199;", "Orders"), ("&#9432;", "About")]
    out = []
    for i, (ic, label) in enumerate(items):
        cls = "it on" if i == active else "it"
        out.append(f"<div class='{cls}'><div class='ic'>{ic}</div>{label}</div>")
    return f"<div class='nav'>{''.join(out)}</div>"


def series_row(emoji, name, sub, tone):
    return (f"<div class='row'><div class='ric' style='background:{tone}22;border:2px solid {tone}66'>"
            f"{emoji}</div><div><div class='rt'>{name}</div>"
            f"<div class='rs'>{sub}</div></div><div class='chev'>&#8250;</div></div>")


def screen_list():
    rows = [
        ("&#128250;", "Monogatari", "Bakemonogatari and beyond · 11 steps", "#5B7CFF"),
        ("&#9876;", "Fate", "Fate/stay night universe · 8 steps", "#2FD4C4"),
        ("&#127916;", "Studio Ghibli", "A route through the classics · 8 steps", "#FFC24B"),
        ("&#128123;", "JoJo's Bizarre Adventure", "Joestar family saga · 6 steps", "#B07CFF"),
    ]
    body = (f"<div class='screen'>{status()}{header()}"
            "<div class='search'>&#128269; Search a series</div>"
            "<div class='meta'><span>15 series</span>"
            "<span class='pill'>113 steps bundled</span></div>"
            f"{''.join(series_row(*r) for r in rows)}"
            f"{nav(0)}</div>")
    return page(body, 1080, 1920)


def screen_detail():
    steps = [
        (1, "Bakemonogatari", "The entry point.", False, True),
        (2, "Nisemonogatari", None, False, True),
        (3, "Nekomonogatari (Black)", None, False, True),
        (4, "Monogatari Series: Second Season", "The largest arc block.", False, False),
        (5, "Kizumonogatari films", "A prequel.", True, False),
    ]
    out = ""
    for num, title, note, opt, hasline in steps:
        badge_cls = "badge opt" if opt else "badge"
        opttag = "<span class='opttag'>Optional</span>" if opt else ""
        noteline = f"<div class='stepn'>{note}</div>" if note else ""
        out += (f"<div class='step'><div class='{badge_cls}' style='margin-bottom:26px'>{num}</div>"
                f"<div class='linewrap'><div class='stept'>{title}{opttag}</div>{noteline}</div></div>")
    body = (f"<div class='screen'>{status()}{header()}"
            "<div class='card'><div class='cardh'>"
            "<span class='pill'>&#9776; Release (airing) order</span>"
            "<span class='pill' style='background:rgba(255,194,75,.14);color:#FFC24B;border-color:rgba(255,194,75,.4)'>11 steps</span></div>"
            "<div class='title'>Monogatari</div>"
            "<div class='sub'>Bakemonogatari and beyond</div>"
            "<div class='blurb'>A dialogue-heavy supernatural series best followed in its original airing order for the intended reveals.</div></div>"
            "<div class='sect'>WATCH ORDER</div>"
            f"{out}"
            "<div class='note'>&#8505; Watch orders are editorial suggestions, not official. "
            "Optional steps can be skipped without losing the main story.</div>"
            "</div>")
    return page(body, 1080, 1920)


def screen_search():
    rows = [
        ("&#9876;", "Fate", "Fate/stay night universe · 8 steps", "#2FD4C4"),
        ("&#128250;", "Attack on Titan", "TV seasons and finale specials · 7 steps", "#5B7CFF"),
        ("&#128250;", "Frieren", "Beyond Journey's End · 2 steps", "#2FD4C4"),
    ]
    body = (f"<div class='screen'>{status()}{header()}"
            "<div class='search'>&#128269; fa</div>"
            "<div class='meta'><span>3 series</span>"
            "<span class='pill'>113 steps bundled</span></div>"
            f"{''.join(series_row(*r) for r in rows)}"
            f"{nav(0)}</div>")
    return page(body, 1080, 1920)


def screen_gintama():
    steps = [
        (1, "Gintama (2006)", None, False),
        (2, "Gintama (Season 2)", None, False),
        (5, "Gintama&#176;", None, False),
        (6, "Gintama.", None, False),
        (10, "Gintama: The Very Final", "Ending.", False),
    ]
    out = ""
    for num, title, note, opt in steps:
        noteline = f"<div class='stepn'>{note}</div>" if note else ""
        out += (f"<div class='step'><div class='badge' style='margin-bottom:26px'>{num}</div>"
                f"<div class='linewrap'><div class='stept'>{title}</div>{noteline}</div></div>")
    body = (f"<div class='screen'>{status()}{header()}"
            "<div class='card'><div class='cardh'>"
            "<span class='pill'>&#9776; Season order</span>"
            "<span class='pill' style='background:rgba(255,194,75,.14);color:#FFC24B;border-color:rgba(255,194,75,.4)'>10 steps</span></div>"
            "<div class='title'>Gintama</div>"
            "<div class='sub'>Comedy with serious arcs</div>"
            "<div class='blurb'>Mostly episodic, but the serious arcs build to a finale. Follow the season order and don't skip the movies.</div></div>"
            "<div class='sect'>WATCH ORDER</div>"
            f"{out}</div>")
    return page(body, 1080, 1920)


def screen_about():
    body = (f"<div class='screen'>{status()}{header()}"
            "<div style='text-align:center;padding:24px 44px 0'>"
            "<div style='margin:0 auto;width:150px;height:150px'>" + logomark(150) + "</div>"
            "<div style='font-size:56px;font-weight:900;letter-spacing:-1px;margin-top:26px'>AniEye</div>"
            "<div style='color:#93A0C0;font-size:28px;margin-top:6px'>Anime Watch-Order Helper</div>"
            "<div style='margin-top:20px'><span class='chip' style='margin:0;display:inline-flex'>v1.0.0 &middot; 15 series</span></div></div>"
            "<div style='margin:44px;background:linear-gradient(135deg,rgba(91,124,255,.16),rgba(47,212,196,.10));"
            "border:2px solid rgba(91,124,255,.4);border-radius:28px;padding:34px'>"
            "<div style='font-size:34px;font-weight:800;color:#2FD4C4'>&#128737; Private by design</div>"
            "<div style='color:#EDF1FB;font-size:28px;line-height:1.55;margin-top:14px'>"
            "No internet, no ads, no tracking. AniEye has nothing to collect and never connects to the network.</div></div>"
            "<div style='margin:0 44px'>"
            "<div class='row' style='border:2px solid #27314F;border-radius:20px;margin-bottom:18px'><div class='rt'>0 permissions requested</div></div>"
            "<div class='row' style='border:2px solid #27314F;border-radius:20px;margin-bottom:18px'><div class='rt'>No ads &middot; no analytics</div></div>"
            "<div class='row' style='border:2px solid #27314F;border-radius:20px'><div class='rt'>100% offline watch orders</div></div>"
            "</div></div>")
    return page(body, 1080, 1920)


def feature_graphic():
    body = ("<div class='feature'><div class='fglow'></div><div class='fglow2'></div>"
            "<div class='fleft'><div class='flogo'>" + logomark(170) + "</div>"
            "<div><div class='fname'>AniEye</div>"
            "<div class='ftag'>Know the right watch order &mdash; offline</div>"
            "<div class='fbadges'><span class='fb fb1'>100% offline</span>"
            "<span class='fb fb2'>0 permissions</span>"
            "<span class='fb fb3'>No ads</span></div></div></div></div>")
    return page(body, 1024, 500)


def main():
    if CHROME is None:
        print("Chrome not found; cannot render graphics.")
        return
    render_html(feature_graphic(), GRAPHICS / "feature_graphic_1024x500.png", 1024, 500)
    shots = [
        ("01_series_list", screen_list()),
        ("02_watch_order", screen_detail()),
        ("03_search", screen_search()),
        ("04_gintama_order", screen_gintama()),
        ("05_about_privacy", screen_about()),
    ]
    for name, html in shots:
        render_html(html, SHOTS / f"{name}.png", 1080, 1920)


if __name__ == "__main__":
    main()
