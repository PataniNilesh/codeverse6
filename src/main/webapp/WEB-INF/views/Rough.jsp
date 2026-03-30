<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>HackVerse — Find Your Next Hackathon</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet" />
  <style>
    :root {
      --bg:        #0a0a0f;
      --surface:   #111118;
      --card:      #16161f;
      --border:    #2a2a3a;
      --accent:    #00e5a0;
      --accent2:   #7b5cfa;
      --warn:      #ff6b35;
      --text:      #e8e8f0;
      --muted:     #7070a0;
      --tag-bg:    #1e1e2e;
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: 'DM Sans', sans-serif;
      font-size: 15px;
      min-height: 100vh;
      overflow-x: hidden;
    }

    /* ── NOISE OVERLAY ── */
    body::before {
      content: '';
      position: fixed; inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");
      pointer-events: none; z-index: 999;
    }

    /* ── NAV ── */
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 18px 48px;
      border-bottom: 1px solid var(--border);
      background: rgba(10,10,15,0.85);
      backdrop-filter: blur(16px);
      position: sticky; top: 0; z-index: 100;
    }
    .nav-logo {
      font-family: 'Syne', sans-serif;
      font-weight: 800; font-size: 22px;
      letter-spacing: -0.5px;
    }
    .nav-logo span { color: var(--accent); }
    .nav-actions { display: flex; gap: 12px; align-items: center; }
    .btn-ghost {
      background: none; border: 1px solid var(--border);
      color: var(--text); padding: 8px 18px; border-radius: 8px;
      font-family: 'DM Sans', sans-serif; font-size: 14px;
      cursor: pointer; transition: border-color .2s, color .2s;
    }
    .btn-ghost:hover { border-color: var(--accent); color: var(--accent); }
    .btn-primary {
      background: var(--accent); color: #0a0a0f;
      border: none; padding: 8px 20px; border-radius: 8px;
      font-family: 'DM Sans', sans-serif; font-weight: 600; font-size: 14px;
      cursor: pointer; transition: opacity .2s, transform .15s;
    }
    .btn-primary:hover { opacity: .88; transform: translateY(-1px); }

    /* ── HERO ── */
    .hero {
      padding: 80px 48px 60px;
      max-width: 900px;
      position: relative;
    }
    .hero-eyebrow {
      display: inline-flex; align-items: center; gap: 8px;
      font-size: 12px; font-weight: 500; letter-spacing: 2px;
      text-transform: uppercase; color: var(--accent);
      border: 1px solid rgba(0,229,160,.25); border-radius: 100px;
      padding: 4px 14px; margin-bottom: 24px;
    }
    .hero-eyebrow::before {
      content: ''; width: 6px; height: 6px; border-radius: 50%;
      background: var(--accent); animation: pulse 2s infinite;
    }
    @keyframes pulse {
      0%,100% { opacity: 1; } 50% { opacity: .3; }
    }
    .hero h1 {
      font-family: 'Syne', sans-serif;
      font-size: clamp(40px, 6vw, 72px);
      font-weight: 800; line-height: 1.05;
      letter-spacing: -2px; margin-bottom: 20px;
    }
    .hero h1 em {
      font-style: normal;
      background: linear-gradient(135deg, var(--accent), var(--accent2));
      -webkit-background-clip: text; -webkit-text-fill-color: transparent;
    }
    .hero p { color: var(--muted); font-size: 17px; max-width: 520px; line-height: 1.65; }

    /* ── SEARCH BAR ── */
    .search-wrap {
      padding: 0 48px 40px;
      max-width: 900px;
    }
    .search-bar {
      display: flex; align-items: center; gap: 12px;
      background: var(--surface); border: 1px solid var(--border);
      border-radius: 14px; padding: 10px 18px;
      transition: border-color .2s;
    }
    .search-bar:focus-within { border-color: var(--accent); }
    .search-bar svg { flex-shrink: 0; opacity: .5; }
    .search-bar input {
      background: none; border: none; outline: none;
      color: var(--text); font-family: 'DM Sans', sans-serif;
      font-size: 15px; flex: 1;
    }
    .search-bar input::placeholder { color: var(--muted); }

    /* ── LAYOUT ── */
    .page-layout {
      display: grid;
      grid-template-columns: 260px 1fr;
      gap: 0;
      padding: 0 48px 80px;
      max-width: 1400px;
      margin: 0 auto;
    }

    /* ── SIDEBAR ── */
    .sidebar {
      padding-right: 32px;
      position: sticky; top: 80px;
      align-self: start;
      max-height: calc(100vh - 100px);
      overflow-y: auto;
    }
    .sidebar::-webkit-scrollbar { width: 4px; }
    .sidebar::-webkit-scrollbar-track { background: transparent; }
    .sidebar::-webkit-scrollbar-thumb { background: var(--border); border-radius: 2px; }

    .filter-group { margin-bottom: 28px; }
    .filter-label {
      font-family: 'Syne', sans-serif;
      font-size: 11px; font-weight: 700;
      letter-spacing: 1.5px; text-transform: uppercase;
      color: var(--muted); margin-bottom: 12px;
      display: flex; align-items: center; gap: 8px;
    }
    .filter-label::after {
      content: ''; flex: 1; height: 1px; background: var(--border);
    }

    .chip-group { display: flex; flex-wrap: wrap; gap: 8px; }
    .chip {
      padding: 6px 14px; border-radius: 100px;
      border: 1px solid var(--border); background: var(--tag-bg);
      color: var(--muted); font-size: 13px; cursor: pointer;
      transition: all .18s; user-select: none;
    }
    .chip:hover { border-color: var(--accent); color: var(--text); }
    .chip.active {
      border-color: var(--accent); background: rgba(0,229,160,.12);
      color: var(--accent);
    }

    .range-row {
      display: flex; align-items: center; gap: 10px;
      font-size: 13px; color: var(--muted);
    }
    .range-row input[type=range] {
      flex: 1; accent-color: var(--accent);
    }
    .range-val { color: var(--accent); font-weight: 600; min-width: 32px; }

    .filter-clear {
      margin-top: 6px;
      background: none; border: none; color: var(--muted);
      font-family: 'DM Sans', sans-serif; font-size: 13px;
      cursor: pointer; text-decoration: underline;
      transition: color .2s;
    }
    .filter-clear:hover { color: var(--warn); }

    /* ── MAIN CONTENT ── */
    .main-content { min-width: 0; }

    .results-header {
      display: flex; align-items: center; justify-content: space-between;
      margin-bottom: 20px;
    }
    .results-count {
      font-size: 13px; color: var(--muted);
    }
    .results-count strong { color: var(--text); }

    .sort-select {
      background: var(--surface); border: 1px solid var(--border);
      color: var(--text); font-family: 'DM Sans', sans-serif;
      font-size: 13px; padding: 7px 14px; border-radius: 8px;
      cursor: pointer; outline: none;
    }

    /* ── CARDS GRID ── */
    .cards-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
    }

    .hack-card {
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: 16px; overflow: hidden;
      display: flex; flex-direction: column;
      transition: border-color .2s, transform .2s, box-shadow .2s;
      cursor: pointer; position: relative;
    }
    .hack-card:hover {
      border-color: rgba(0,229,160,.4);
      transform: translateY(-4px);
      box-shadow: 0 20px 60px rgba(0,0,0,.4);
    }

    .card-banner {
      height: 100px; position: relative; overflow: hidden;
    }
    .card-banner-img {
      width: 100%; height: 100%; object-fit: cover;
    }
    /* Gradient fallback banners */
    .banner-1 { background: linear-gradient(135deg,#1a0533,#7b5cfa,#00e5a0); }
    .banner-2 { background: linear-gradient(135deg,#0d1f3c,#1a6bff,#00e5a0); }
    .banner-3 { background: linear-gradient(135deg,#330a0a,#ff4444,#ff6b35); }
    .banner-4 { background: linear-gradient(135deg,#0a1a1a,#00b4a0,#00e5a0); }
    .banner-5 { background: linear-gradient(135deg,#1a1a0a,#c8a000,#ff6b35); }
    .banner-6 { background: linear-gradient(135deg,#0f0a1f,#4b0082,#7b5cfa); }

    .card-badge-wrap {
      position: absolute; top: 10px; right: 10px;
      display: flex; gap: 6px;
    }
    .badge {
      font-size: 10px; font-weight: 700; letter-spacing: .8px;
      text-transform: uppercase; padding: 3px 9px; border-radius: 100px;
    }
    .badge-free  { background: rgba(0,229,160,.2); color: var(--accent); border: 1px solid rgba(0,229,160,.35); }
    .badge-paid  { background: rgba(255,107,53,.15); color: var(--warn);  border: 1px solid rgba(255,107,53,.3); }
    .badge-live  { background: rgba(255,50,50,.2);   color: #ff5050;      border: 1px solid rgba(255,50,50,.35);
                   animation: badge-pulse 2s infinite; }
    @keyframes badge-pulse {
      0%,100% { opacity: 1; } 50% { opacity: .6; }
    }

    .card-logo {
      position: absolute; bottom: -20px; left: 18px;
      width: 44px; height: 44px; border-radius: 12px;
      border: 2px solid var(--border);
      background: var(--card);
      display: flex; align-items: center; justify-content: center;
      font-family: 'Syne', sans-serif; font-weight: 800; font-size: 16px;
      color: var(--accent);
    }

    .card-body { padding: 28px 18px 18px; flex: 1; display: flex; flex-direction: column; gap: 10px; }

    .card-title {
      font-family: 'Syne', sans-serif;
      font-size: 16px; font-weight: 700; line-height: 1.3;
      margin-top: 4px;
    }
    .card-org { font-size: 12px; color: var(--muted); }

    .card-meta {
      display: flex; flex-wrap: wrap; gap: 10px;
      font-size: 12px; color: var(--muted);
    }
    .meta-item { display: flex; align-items: center; gap: 5px; }

    .card-tags { display: flex; flex-wrap: wrap; gap: 6px; }
    .tag {
      background: var(--tag-bg); border: 1px solid var(--border);
      color: var(--muted); font-size: 11px; padding: 3px 10px;
      border-radius: 100px;
    }

    .card-footer {
      border-top: 1px solid var(--border);
      padding: 14px 18px;
      display: flex; align-items: center; justify-content: space-between;
    }
    .prize-pool {
      font-family: 'Syne', sans-serif;
      font-size: 17px; font-weight: 700; color: var(--accent);
    }
    .prize-label { font-size: 10px; color: var(--muted); text-transform: uppercase; letter-spacing: .8px; }

    .deadline {
      text-align: right;
    }
    .deadline-val { font-size: 13px; font-weight: 500; }
    .deadline-label { font-size: 10px; color: var(--muted); text-transform: uppercase; letter-spacing: .8px; }
    .deadline-val.urgent { color: var(--warn); }

    /* ── LOAD MORE ── */
    .load-more-wrap { text-align: center; margin-top: 40px; }
    .btn-load-more {
      background: none; border: 1px solid var(--border);
      color: var(--text); padding: 12px 40px; border-radius: 100px;
      font-family: 'DM Sans', sans-serif; font-weight: 500;
      cursor: pointer; transition: all .2s; font-size: 14px;
    }
    .btn-load-more:hover { border-color: var(--accent); color: var(--accent); background: rgba(0,229,160,.05); }

    /* ── EMPTY STATE ── */
    .empty-state {
      text-align: center; padding: 80px 20px; color: var(--muted);
      display: none;
    }
    .empty-state h3 { font-family: 'Syne', sans-serif; font-size: 20px; color: var(--text); margin-bottom: 8px; }

    /* ── RESPONSIVE ── */
    @media (max-width: 900px) {
      nav { padding: 14px 20px; }
      .hero, .search-wrap { padding-left: 20px; padding-right: 20px; }
      .page-layout { grid-template-columns: 1fr; padding: 0 20px 60px; }
      .sidebar { position: static; max-height: none; padding-right: 0; }
    }
  </style>
</head>
<body>

<!-- ── NAV ── -->
<nav>
  <div class="nav-logo">Hack<span>Verse</span></div>
  <div class="nav-actions">
    <button class="btn-ghost">Login</button>
    <button class="btn-primary">+ Submit Hackathon</button>
  </div>
</nav>

<!-- ── HERO ── -->
<div class="hero">
  <div class="hero-eyebrow">Hackathons · Competitions · Buildathons</div>
  <h1>Find hackathons<br/>made for <em>builders</em></h1>
  <p>Discover 200+ open hackathons — filter by cost, team size, experience level, domain, and more.</p>
</div>

<!-- ── SEARCH ── -->
<div class="search-wrap">
  <div class="search-bar">
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
    </svg>
    <input type="text" id="searchInput" placeholder="Search by name, theme, tech stack…" oninput="applyFilters()" />
  </div>
</div>

<!-- ── LAYOUT ── -->
<div class="page-layout">

  <!-- SIDEBAR FILTERS -->
  <aside class="sidebar">

    <div class="filter-group">
      <div class="filter-label">Entry</div>
      <div class="chip-group">
        <div class="chip" data-filter="entry" data-value="free"   onclick="toggleChip(this)">Free</div>
        <div class="chip" data-filter="entry" data-value="paid"   onclick="toggleChip(this)">Paid</div>
        <div class="chip" data-filter="entry" data-value="invite" onclick="toggleChip(this)">Invite Only</div>
      </div>
    </div>

    <div class="filter-group">
      <div class="filter-label">Experience</div>
      <div class="chip-group">
        <div class="chip" data-filter="exp" data-value="fresher"      onclick="toggleChip(this)">Fresher</div>
        <div class="chip" data-filter="exp" data-value="professional" onclick="toggleChip(this)">Working Pro</div>
        <div class="chip" data-filter="exp" data-value="student"      onclick="toggleChip(this)">Student</div>
        <div class="chip" data-filter="exp" data-value="open"         onclick="toggleChip(this)">Open to All</div>
      </div>
    </div>

    <div class="filter-group">
      <div class="filter-label">Mode</div>
      <div class="chip-group">
        <div class="chip" data-filter="mode" data-value="online"  onclick="toggleChip(this)">Online</div>
        <div class="chip" data-filter="mode" data-value="offline" onclick="toggleChip(this)">In-Person</div>
        <div class="chip" data-filter="mode" data-value="hybrid"  onclick="toggleChip(this)">Hybrid</div>
      </div>
    </div>

    <div class="filter-group">
      <div class="filter-label">Max Team Size</div>
      <div class="range-row">
        <span>1</span>
        <input type="range" id="teamSizeRange" min="1" max="10" value="10" oninput="updateTeamSize(this)" />
        <span class="range-val" id="teamSizeVal">10</span>
      </div>
    </div>

    <div class="filter-group">
      <div class="filter-label">Domain</div>
      <div class="chip-group">
        <div class="chip" data-filter="domain" data-value="ai"         onclick="toggleChip(this)">AI / ML</div>
        <div class="chip" data-filter="domain" data-value="web3"       onclick="toggleChip(this)">Web3</div>
        <div class="chip" data-filter="domain" data-value="healthtech" onclick="toggleChip(this)">HealthTech</div>
        <div class="chip" data-filter="domain" data-value="fintech"    onclick="toggleChip(this)">FinTech</div>
        <div class="chip" data-filter="domain" data-value="sustainability" onclick="toggleChip(this)">Green Tech</div>
        <div class="chip" data-filter="domain" data-value="open"       onclick="toggleChip(this)">Open Theme</div>
      </div>
    </div>

    <div class="filter-group">
      <div class="filter-label">Status</div>
      <div class="chip-group">
        <div class="chip" data-filter="status" data-value="open"     onclick="toggleChip(this)">Open</div>
        <div class="chip" data-filter="status" data-value="live"     onclick="toggleChip(this)">🔴 Live Now</div>
        <div class="chip" data-filter="status" data-value="upcoming" onclick="toggleChip(this)">Upcoming</div>
      </div>
    </div>

    <button class="filter-clear" onclick="clearFilters()">Clear all filters</button>
  </aside>

  <!-- MAIN -->
  <main class="main-content">
    <div class="results-header">
      <div class="results-count">Showing <strong id="countDisplay">6</strong> hackathons</div>
      <select class="sort-select" onchange="applyFilters()">
        <option value="deadline">Sort: Deadline</option>
        <option value="prize">Sort: Prize Pool</option>
        <option value="newest">Sort: Newest</option>
      </select>
    </div>

    <div class="cards-grid" id="cardsGrid"></div>
    <div class="empty-state" id="emptyState">
      <h3>No hackathons found</h3>
      <p>Try adjusting your filters or search query.</p>
    </div>

    <div class="load-more-wrap">
      <button class="btn-load-more">Load more hackathons</button>
    </div>
  </main>
</div>

<script>
  /* ──────────────────────────────────────
     DATA — replace / extend with server-side
     JSTL / EL values as needed, e.g.:
     const hackathons = ${hackathonListJson};
  ────────────────────────────────────── */
  const hackathons = [
    {
      id: 1, title: "DeepBuild AI Hackathon 2025",
      org: "Google DeepMind", banner: "banner-1", logo: "DB",
      entry: "free", exp: ["student","fresher","open"],
      mode: "online", teamSize: 4, domain: ["ai"],
      status: "open", prize: "₹5,00,000", deadline: "Apr 12",
      daysLeft: 25, tags: ["LLMs","Gemini API","Python"],
      desc: "Build next-gen AI tools using Gemini APIs."
    },
    {
      id: 2, title: "ETHIndia 2025 — Web3 Sprint",
      org: "Devfolio", banner: "banner-2", logo: "EI",
      entry: "free", exp: ["student","professional","open"],
      mode: "offline", teamSize: 5, domain: ["web3"],
      status: "open", prize: "$80,000", deadline: "Apr 5",
      daysLeft: 18, tags: ["Solidity","EVM","DeFi"],
      desc: "India's largest Ethereum hackathon. Build, ship, earn."
    },
    {
      id: 3, title: "HealthHack Pro",
      org: "Apollo Health Ventures", banner: "banner-3", logo: "HH",
      entry: "paid", exp: ["professional"],
      mode: "hybrid", teamSize: 6, domain: ["healthtech"],
      status: "upcoming", prize: "₹2,00,000", deadline: "May 1",
      daysLeft: 44, tags: ["MedTech","IoT","React"],
      desc: "Solve India's healthcare last-mile challenges."
    },
    {
      id: 4, title: "FinFusion Hackathon",
      org: "Razorpay x Zerodha", banner: "banner-5", logo: "FF",
      entry: "free", exp: ["fresher","student","open"],
      mode: "online", teamSize: 3, domain: ["fintech"],
      status: "live", prize: "₹3,50,000", deadline: "Mar 20",
      daysLeft: 2, tags: ["Payments","APIs","Node.js"],
      desc: "Reimagine financial infra for Bharat."
    },
    {
      id: 5, title: "GreenBuild Climate Hackathon",
      org: "UNDP India", banner: "banner-4", logo: "GB",
      entry: "free", exp: ["open"],
      mode: "online", teamSize: 5, domain: ["sustainability"],
      status: "open", prize: "$20,000", deadline: "Apr 28",
      daysLeft: 41, tags: ["Climate","Satellite Data","ML"],
      desc: "Data-driven solutions for climate resilience."
    },
    {
      id: 6, title: "Hack The Web — Open Theme",
      org: "GitHub Education", banner: "banner-6", logo: "HW",
      entry: "free", exp: ["student","fresher"],
      mode: "online", teamSize: 4, domain: ["open"],
      status: "open", prize: "$10,000", deadline: "Apr 19",
      daysLeft: 32, tags: ["Open Source","Any Stack","Solo OK"],
      desc: "Build anything. Ship it. Win prizes."
    },
  ];

  /* ── ACTIVE FILTERS STATE ── */
  const filters = { entry: [], exp: [], mode: [], domain: [], status: [], teamSize: 10 };

  function toggleChip(el) {
    const { filter, value } = el.dataset;
    const arr = filters[filter];
    const idx = arr.indexOf(value);
    if (idx === -1) { arr.push(value); el.classList.add('active'); }
    else { arr.splice(idx, 1); el.classList.remove('active'); }
    applyFilters();
  }

  function updateTeamSize(el) {
    filters.teamSize = parseInt(el.value);
    document.getElementById('teamSizeVal').textContent = el.value;
    applyFilters();
  }

  function clearFilters() {
    Object.keys(filters).forEach(k => { filters[k] = Array.isArray(filters[k]) ? [] : 10; });
    document.querySelectorAll('.chip').forEach(c => c.classList.remove('active'));
    document.getElementById('teamSizeRange').value = 10;
    document.getElementById('teamSizeVal').textContent = '10';
    document.getElementById('searchInput').value = '';
    applyFilters();
  }

  function applyFilters() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    const result = hackathons.filter(h => {
      if (q && !h.title.toLowerCase().includes(q) && !h.tags.join(' ').toLowerCase().includes(q) && !h.org.toLowerCase().includes(q)) return false;
      if (filters.entry.length  && !filters.entry.includes(h.entry))                          return false;
      if (filters.exp.length    && !filters.exp.some(e => h.exp.includes(e)))                 return false;
      if (filters.mode.length   && !filters.mode.includes(h.mode))                            return false;
      if (filters.domain.length && !filters.domain.some(d => h.domain.includes(d)))           return false;
      if (filters.status.length && !filters.status.includes(h.status))                        return false;
      if (h.teamSize > filters.teamSize)                                                       return false;
      return true;
    });
    renderCards(result);
  }

  /* ── RENDER ── */
  function renderCards(data) {
    const grid  = document.getElementById('cardsGrid');
    const empty = document.getElementById('emptyState');
    document.getElementById('countDisplay').textContent = data.length;

    if (!data.length) {
      grid.innerHTML = ''; empty.style.display = 'block'; return;
    }
    empty.style.display = 'none';

    grid.innerHTML = data.map(h => `
      <div class="hack-card" onclick="viewHackathon(${h.id})">
        <div class="card-banner ${h.banner}">
          <div class="card-badge-wrap">
            ${h.status === 'live' ? '<span class="badge badge-live">🔴 Live</span>' : ''}
            <span class="badge ${h.entry === 'free' ? 'badge-free' : 'badge-paid'}">
              ${h.entry === 'free' ? 'Free' : h.entry === 'paid' ? 'Paid' : 'Invite'}
            </span>
          </div>
          <div class="card-logo">${h.logo}</div>
        </div>
        <div class="card-body">
          <div class="card-org">${h.org}</div>
          <div class="card-title">${h.title}</div>
          <div class="card-meta">
            <span class="meta-item">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
              Up to ${h.teamSize}
            </span>
            <span class="meta-item">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>
              ${h.mode.charAt(0).toUpperCase() + h.mode.slice(1)}
            </span>
            <span class="meta-item">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
              ${h.exp.includes('open') ? 'Open to All' : h.exp.map(e => e.charAt(0).toUpperCase()+e.slice(1)).join(', ')}
            </span>
          </div>
          <div class="card-tags">
            ${h.tags.map(t => `<span class="tag">${t}</span>`).join('')}
          </div>
        </div>
        <div class="card-footer">
          <div>
            <div class="prize-label">Prize Pool</div>
            <div class="prize-pool">${h.prize}</div>
          </div>
          <div class="deadline">
            <div class="deadline-label">Deadline</div>
            <div class="deadline-val ${h.daysLeft <= 5 ? 'urgent' : ''}">${h.deadline}</div>
          </div>
        </div>
      </div>
    `).join('');
  }

  function viewHackathon(id) {
    // Navigate to detail page — replace with your JSP route
    console.log('Navigate to hackathon detail:', id);
    // window.location.href = 'hackathon-detail.jsp?id=' + id;
  }

  // Initial render
  renderCards(hackathons);
</script>
</body>
</html>
