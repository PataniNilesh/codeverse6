<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ICH &mdash; Participant Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,300;0,400;0,500;0,700;1,400&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet">
<style>
/* ─── Reset & Root ─────────────────────────────────────── */
*{box-sizing:border-box;margin:0;padding:0}
:root{
  --white:#ffffff;
  --bg:#f5f4f0;
  --bg2:#eeede8;
  --border:#e0ddd5;
  --text:#1a1916;
  --text2:#5c5a55;
  --text3:#9a9891;
  --accent:#e8520a;
  --accent-pale:#fdf2ec;
  --accent-pale2:#fce4d4;
  --green:#1a7a4a;
  --green-pale:#e8f5ee;
  --blue:#1356a8;
  --blue-pale:#e8f0fb;
  --amber:#b06a00;
  --amber-pale:#fef4e0;
  --red:#c0392b;
  --red-pale:#fdf0ef;
  --radius:14px;
  --shadow:0 2px 16px rgba(30,28,22,.08);
  --shadow-lg:0 8px 40px rgba(30,28,22,.13);
}

html,body{font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--text);min-height:100vh;font-size:15px;line-height:1.55}

/* ─── Layout ─────────────────────────────────────────────── */
.dash-wrap{display:flex;min-height:100vh}

/* ─── Sidebar ─────────────────────────────────────────────── */
.sidebar{
  width:240px;flex-shrink:0;
  background:var(--white);
  border-right:1px solid var(--border);
  display:flex;flex-direction:column;
  position:sticky;top:0;height:100vh;
  padding:0 0 20px;
}
.sidebar-brand{
  padding:22px 22px 18px;
  border-bottom:1px solid var(--border);
}
.brand-badge{
  display:inline-flex;align-items:center;gap:8px;
}
.brand-icon{
  width:32px;height:32px;
  background:var(--accent);
  border-radius:9px;
  display:flex;align-items:center;justify-content:center;
  flex-shrink:0;
}
.brand-icon svg{display:block}
.brand-text{font-family:'DM Serif Display',serif;font-size:16px;color:var(--text);line-height:1.2}
.brand-sub{font-size:10px;font-weight:500;color:var(--text3);letter-spacing:.6px;text-transform:uppercase;margin-top:2px}

.sidebar-nav{flex:1;padding:14px 12px;overflow-y:auto}
.nav-section{margin-bottom:20px}
.nav-section-label{font-size:10px;font-weight:700;letter-spacing:1.2px;text-transform:uppercase;color:var(--text3);padding:0 10px;margin-bottom:6px}
.nav-item{
  display:flex;align-items:center;gap:10px;
  padding:10px 12px;border-radius:10px;
  color:var(--text2);font-size:14px;font-weight:500;
  text-decoration:none;transition:all .18s;cursor:pointer;
}
.nav-item:hover{background:var(--bg);color:var(--text)}
.nav-item.active{background:var(--accent-pale);color:var(--accent);font-weight:700}
.nav-item svg{flex-shrink:0;opacity:.7}
.nav-item.active svg{opacity:1}

.sidebar-user{
  padding:14px 14px 0;
  border-top:1px solid var(--border);
}
.user-pill{
  display:flex;align-items:center;gap:10px;
  padding:10px 12px;background:var(--bg);
  border-radius:12px;text-decoration:none;color:var(--text);
  transition:background .18s;
}
.user-pill:hover{background:var(--bg2)}
.user-avatar{
  width:34px;height:34px;border-radius:50%;
  background:linear-gradient(135deg,var(--accent),#f4822a);
  display:flex;align-items:center;justify-content:center;
  font-family:'DM Serif Display',serif;font-size:14px;
  color:#fff;flex-shrink:0;overflow:hidden;
}
.user-avatar img{width:100%;height:100%;object-fit:cover}
.user-name{font-size:13px;font-weight:700;line-height:1.2}
.user-role{font-size:11px;color:var(--text3)}

/* ─── Main ────────────────────────────────────────────────── */
.main{flex:1;min-width:0;display:flex;flex-direction:column}

/* ─── Top bar ─────────────────────────────────────────────── */
.topbar{
  background:var(--white);border-bottom:1px solid var(--border);
  padding:0 28px;height:60px;
  display:flex;align-items:center;justify-content:space-between;
  position:sticky;top:0;z-index:50;gap:12px;
}
.topbar-left{display:flex;align-items:center;gap:12px}
.topbar-title{font-family:'DM Serif Display',serif;font-size:18px}
.topbar-right{display:flex;align-items:center;gap:8px}
.topbar-btn{
  display:inline-flex;align-items:center;gap:6px;
  padding:8px 14px;border-radius:9px;
  font-size:13px;font-weight:600;text-decoration:none;
  border:1px solid var(--border);background:var(--white);
  color:var(--text2);transition:all .18s;cursor:pointer;
}
.topbar-btn:hover{background:var(--bg);border-color:var(--text3)}
.topbar-btn.primary{background:var(--accent);color:#fff;border-color:var(--accent)}
.topbar-btn.primary:hover{background:#d04608}

/* ─── Content ─────────────────────────────────────────────── */
.content{padding:28px;flex:1}

/* ─── Hero banner ─────────────────────────────────────────── */
.hero{
  background:var(--white);border:1px solid var(--border);
  border-radius:var(--radius);padding:28px 32px;
  display:flex;align-items:center;justify-content:space-between;
  gap:20px;flex-wrap:wrap;overflow:hidden;position:relative;
  margin-bottom:24px;
}
.hero::before{
  content:'';position:absolute;right:-60px;top:-60px;
  width:240px;height:240px;
  background:radial-gradient(circle,var(--accent-pale2) 0%,transparent 70%);
  pointer-events:none;
}
.hero-text{}
.hero-eyebrow{
  font-size:11px;font-weight:700;letter-spacing:1.2px;text-transform:uppercase;
  color:var(--accent);margin-bottom:8px;
}
.hero-title{
  font-family:'DM Serif Display',serif;
  font-size:26px;line-height:1.15;color:var(--text);
}
.hero-title span{font-style:italic}
.hero-sub{font-size:14px;color:var(--text2);margin-top:8px;max-width:420px}
.hero-actions{display:flex;gap:10px;margin-top:18px;flex-wrap:wrap}
.btn{
  display:inline-flex;align-items:center;gap:7px;
  padding:10px 18px;border-radius:10px;
  font-size:14px;font-weight:600;text-decoration:none;
  border:none;cursor:pointer;transition:all .2s;
  font-family:'DM Sans',sans-serif;
}
.btn-primary{background:var(--accent);color:#fff}
.btn-primary:hover{background:#d04608;transform:translateY(-1px)}
.btn-outline{background:transparent;color:var(--text);border:1px solid var(--border)}
.btn-outline:hover{background:var(--bg);border-color:var(--text3)}
.hero-art{
  flex-shrink:0;
  width:90px;height:90px;
  background:linear-gradient(135deg,var(--accent),#f4822a);
  border-radius:20px;
  display:flex;align-items:center;justify-content:center;
  box-shadow:0 10px 30px rgba(232,82,10,.25);
}
.hero-art svg{display:block}

/* ─── Stat row ─────────────────────────────────────────────── */
.stat-row{
  display:grid;grid-template-columns:repeat(4,1fr);gap:14px;
  margin-bottom:24px;
}
.stat-card{
  background:var(--white);border:1px solid var(--border);
  border-radius:var(--radius);padding:18px 20px;
  position:relative;overflow:hidden;transition:box-shadow .2s;
}
.stat-card:hover{box-shadow:var(--shadow)}
.stat-card::before{
  content:'';position:absolute;top:0;left:0;right:0;height:3px;
  border-radius:var(--radius) var(--radius) 0 0;
}
.stat-card.orange::before{background:var(--accent)}
.stat-card.green::before{background:var(--green)}
.stat-card.blue::before{background:var(--blue)}
.stat-card.amber::before{background:#e8a800}
.stat-label{font-size:12px;font-weight:600;color:var(--text3);letter-spacing:.4px;text-transform:uppercase;margin-bottom:8px}
.stat-value{font-family:'DM Serif Display',serif;font-size:28px;color:var(--text);line-height:1}
.stat-note{font-size:12px;color:var(--text3);margin-top:5px}
.stat-note b{color:var(--text2)}
.stat-icon{
  position:absolute;right:16px;top:16px;
  width:34px;height:34px;border-radius:9px;
  display:flex;align-items:center;justify-content:center;
}
.stat-icon.orange{background:var(--accent-pale)}
.stat-icon.green{background:var(--green-pale)}
.stat-icon.blue{background:var(--blue-pale)}
.stat-icon.amber{background:var(--amber-pale)}

/* ─── Two-col grid ─────────────────────────────────────────── */
.grid-2{display:grid;grid-template-columns:1.5fr 1fr;gap:18px;margin-bottom:24px}

/* ─── Cards ─────────────────────────────────────────────────── */
.card{
  background:var(--white);border:1px solid var(--border);
  border-radius:var(--radius);overflow:hidden;
}
.card-head{
  display:flex;align-items:center;justify-content:space-between;
  padding:16px 20px;border-bottom:1px solid var(--border);
}
.card-head-title{font-size:14px;font-weight:700;color:var(--text)}
.card-head-link{font-size:13px;font-weight:600;color:var(--accent);text-decoration:none}
.card-head-link:hover{text-decoration:underline}
.card-body{padding:16px 20px}

/* ─── Hackathon list ─────────────────────────────────────────── */
.hack-item{
  display:flex;align-items:flex-start;gap:14px;
  padding:14px 0;border-bottom:1px solid var(--border);
}
.hack-item:last-child{border-bottom:none}
.hack-thumb{
  width:44px;height:44px;border-radius:10px;flex-shrink:0;
  background:linear-gradient(135deg,#e0e9f8,#c8d8f2);
  display:flex;align-items:center;justify-content:center;font-size:20px;
}
.hack-thumb.t2{background:linear-gradient(135deg,#fde8d0,#f8c898)}
.hack-thumb.t3{background:linear-gradient(135deg,#d8f2e8,#b4e4cc)}
.hack-thumb.t4{background:linear-gradient(135deg,#f0e0f8,#dcc4ee)}
.hack-info{flex:1;min-width:0}
.hack-title{font-size:14px;font-weight:700;color:var(--text);margin-bottom:3px;
  white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.hack-meta{font-size:12px;color:var(--text3);display:flex;gap:10px;flex-wrap:wrap}
.hack-badge{
  display:inline-flex;align-items:center;
  padding:3px 8px;border-radius:100px;font-size:11px;font-weight:700;
  font-family:'DM Sans',monospace;
}
.badge-green{background:var(--green-pale);color:var(--green)}
.badge-amber{background:var(--amber-pale);color:var(--amber)}
.badge-blue{background:var(--blue-pale);color:var(--blue)}
.badge-red{background:var(--red-pale);color:var(--red)}
.badge-grey{background:var(--bg2);color:var(--text2)}
.badge-orange{background:var(--accent-pale);color:var(--accent)}

/* ─── Activity feed ──────────────────────────────────────────── */
.activity-item{
  display:flex;align-items:flex-start;gap:12px;
  padding:12px 0;border-bottom:1px solid var(--border);
}
.activity-item:last-child{border-bottom:none}
.activity-dot{
  width:32px;height:32px;border-radius:50%;flex-shrink:0;
  display:flex;align-items:center;justify-content:center;margin-top:1px;
}
.dot-green{background:var(--green-pale)}
.dot-blue{background:var(--blue-pale)}
.dot-orange{background:var(--accent-pale)}
.dot-amber{background:var(--amber-pale)}
.activity-text{font-size:13px;color:var(--text2);line-height:1.5;flex:1}
.activity-text b{color:var(--text);font-weight:700}
.activity-time{font-size:11px;color:var(--text3);margin-top:2px}

/* ─── Countdown ──────────────────────────────────────────────── */
.countdown-card{
  background:linear-gradient(135deg,#1a1916 0%,#2d2c28 100%);
  border:none;color:#fff;
}
.countdown-card .card-head{border-bottom-color:rgba(255,255,255,.1)}
.countdown-card .card-head-title{color:rgba(255,255,255,.9)}
.countdown-card .card-head-link{color:#f4822a}
.countdown-banner{padding:20px;text-align:center}
.countdown-label{font-size:11px;font-weight:700;letter-spacing:1.2px;text-transform:uppercase;color:rgba(255,255,255,.5);margin-bottom:8px}
.countdown-hack-name{font-family:'DM Serif Display',serif;font-size:17px;color:#fff;margin-bottom:16px;line-height:1.3}
.countdown-timer{display:flex;gap:10px;justify-content:center;margin-bottom:16px}
.countdown-unit{
  background:rgba(255,255,255,.08);border-radius:10px;
  padding:10px 14px;min-width:58px;
}
.countdown-num{font-family:'DM Serif Display',serif;font-size:26px;color:#fff;line-height:1}
.countdown-sep{font-size:24px;color:rgba(255,255,255,.25);line-height:1;align-self:flex-start;padding-top:14px}
.countdown-unit-label{font-size:10px;color:rgba(255,255,255,.4);margin-top:4px;text-transform:uppercase;letter-spacing:.5px}
.countdown-note{font-size:13px;color:rgba(255,255,255,.5);margin-bottom:14px}

/* ─── Progress bar ───────────────────────────────────────────── */
.progress-row{display:flex;align-items:center;gap:10px;margin-bottom:10px}
.progress-label{font-size:13px;font-weight:600;flex:1;color:var(--text2)}
.progress-pct{font-size:12px;font-weight:700;color:var(--text2);width:32px;text-align:right}
.progress-bar-wrap{flex:1;height:6px;background:var(--bg2);border-radius:100px;overflow:hidden}
.progress-bar-fill{height:100%;border-radius:100px;background:var(--accent);transition:width .4s}
.progress-bar-fill.green{background:var(--green)}
.progress-bar-fill.blue{background:var(--blue)}

/* ─── Full-width section ─────────────────────────────────────── */
.section-row{margin-bottom:24px}
.section-label{font-family:'DM Serif Display',serif;font-size:18px;color:var(--text);margin-bottom:14px}

/* ─── Explore hackathon grid ─────────────────────────────────── */
.explore-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:14px}
.explore-card{
  background:var(--white);border:1px solid var(--border);
  border-radius:var(--radius);overflow:hidden;
  transition:all .2s;
}
.explore-card:hover{box-shadow:var(--shadow);transform:translateY(-2px)}
.explore-banner{
  height:70px;display:flex;align-items:center;justify-content:center;font-size:28px;
}
.explore-banner.b1{background:linear-gradient(135deg,#e0e9f8,#c8d8f2)}
.explore-banner.b2{background:linear-gradient(135deg,#fde8d0,#f8c898)}
.explore-banner.b3{background:linear-gradient(135deg,#d8f2e8,#b4e4cc)}
.explore-info{padding:14px 16px}
.explore-title{font-size:14px;font-weight:700;color:var(--text);margin-bottom:5px}
.explore-meta{font-size:12px;color:var(--text3);margin-bottom:10px;display:flex;flex-wrap:wrap;gap:6px}
.explore-footer{display:flex;align-items:center;justify-content:space-between;padding-top:10px;border-top:1px solid var(--border)}
.explore-price{font-size:12px;font-weight:700}
.explore-price.free{color:var(--green)}
.explore-price.paid{color:var(--amber)}

/* ─── Footer ─────────────────────────────────────────────────── */
.dash-footer{
  padding:16px 28px;border-top:1px solid var(--border);
  font-size:12px;color:var(--text3);background:var(--white);
  display:flex;align-items:center;justify-content:space-between;
}

/* ─── Responsive ─────────────────────────────────────────────── */
@media(max-width:1100px){
  .stat-row{grid-template-columns:repeat(2,1fr)}
  .grid-2{grid-template-columns:1fr}
  .explore-grid{grid-template-columns:repeat(2,1fr)}
}
@media(max-width:780px){
  .sidebar{display:none}
  .content{padding:16px}
  .explore-grid{grid-template-columns:1fr}
}
</style>
</head>
<body>
<div class="dash-wrap">

  <!-- ══ SIDEBAR ══ -->
  <aside class="sidebar">
    <div class="sidebar-brand">
      <div class="brand-badge">
        <div class="brand-icon">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
          </svg>
        </div>
        <div>
          <div class="brand-text">ICH</div>
          <div class="brand-sub">Interns Coding for Hackathon</div>
        </div>
      </div>
    </div>

    <nav class="sidebar-nav">
      <div class="nav-section">
        <div class="nav-section-label">Main</div>
        <a href="/participant/home" class="nav-item active">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
          Dashboard
        </a>
        <a href="/participant/home" class="nav-item">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          Explore Hackathons
        </a>
        <a href="/participant/my-hackathons" class="nav-item">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg>
          My Hackathons
        </a>
      </div>
      <div class="nav-section">
        <div class="nav-section-label">Team</div>
        <a href="/participant/my-hackathons" class="nav-item">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
          Manage Team
        </a>
        <a href="/participant/my-hackathons" class="nav-item">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="17 8 12 3 7 8"/><line x1="12" y1="3" x2="12" y2="15"/></svg>
          My Submissions
        </a>
        <a href="/participant/home" class="nav-item">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
          Leaderboard
        </a>
      </div>
      <div class="nav-section">
        <div class="nav-section-label">Account</div>
        <a href="/participant/profile" class="nav-item">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
          My Profile
        </a>
        <a href="/logout" class="nav-item">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
          Logout
        </a>
      </div>
    </nav>

    <div class="sidebar-user">
      <a href="/participant/profile" class="user-pill">
        <div class="user-avatar">
          <!-- EL kept exactly -->
          <c:choose>
            <c:when test="${not empty sessionScope.user.profilePicUrl}">
              <img src="${sessionScope.user.profilePicUrl}" alt="avatar">
            </c:when>
            <c:otherwise>${not empty sessionScope.user.firstName ? sessionScope.user.firstName.charAt(0) : 'P'}</c:otherwise>
          </c:choose>
        </div>
        <div>
          <div class="user-name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
          <div class="user-role">Participant</div>
        </div>
      </a>
    </div>
  </aside>

  <!-- ══ MAIN ══ -->
  <div class="main">

    <!-- Top bar -->
    <header class="topbar">
      <div class="topbar-left">
        <div class="topbar-title">Dashboard</div>
      </div>
      <div class="topbar-right">
        <a href="/participant/home" class="topbar-btn">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          Explore
        </a>
        <a href="/participant/my-hackathons" class="topbar-btn primary">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
          My Hackathons
        </a>
      </div>
    </header>

    <!-- Content -->
    <div class="content">

      <!-- ── Hero ── -->
      <div class="hero">
        <div class="hero-text">
          <div class="hero-eyebrow">Interns Coding for Hackathon &nbsp;&bull;&nbsp; Participant Portal</div>
          <h1 class="hero-title">
            Welcome back,
            <span>${not empty sessionScope.user.firstName ? sessionScope.user.firstName : 'Participant'}</span>!
          </h1>
          <p class="hero-sub">Ready to build, compete, and innovate? Your next breakthrough starts here.</p>
          <div class="hero-actions">
            <a href="/participant/home" class="btn btn-primary">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
              Explore Hackathons
            </a>
            <a href="/participant/my-hackathons" class="btn btn-outline">
              My Hackathons
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
            </a>
          </div>
        </div>
        <div class="hero-art">
          <svg width="42" height="42" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
          </svg>
        </div>
      </div>

      <!-- ── Stats ── -->
      <div class="stat-row">
        <div class="stat-card orange">
          <div class="stat-icon orange">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg>
          </div>
          <div class="stat-label">Registered</div>
          <!-- EL kept: ${totalHackathon} -->
          <div class="stat-value">${not empty totalHackathon ? totalHackathon : 0}</div>
          <div class="stat-note">Hackathons joined</div>
        </div>
        <div class="stat-card green">
          <div class="stat-icon green">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--green)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
          </div>
          <div class="stat-label">Active Now</div>
          <div class="stat-value">${not empty ongoingHackathon ? ongoingHackathon : 0}</div>
          <div class="stat-note">Ongoing hackathons</div>
        </div>
        <div class="stat-card blue">
          <div class="stat-icon blue">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
          </div>
          <div class="stat-label">Team Size</div>
          <div class="stat-value">${not empty teamSize ? teamSize : '&mdash;'}</div>
          <div class="stat-note">Members in your team</div>
        </div>
        <div class="stat-card amber">
          <div class="stat-icon amber">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--amber)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="6"/><path d="M15.477 12.89L17 22l-5-3-5 3 1.523-9.11"/></svg>
          </div>
          <div class="stat-label">Upcoming</div>
          <div class="stat-value">${not empty upcomingHackathon ? upcomingHackathon : 0}</div>
          <div class="stat-note">Hackathons upcoming</div>
        </div>
      </div>

      <!-- ── Two-col ── -->
      <div class="grid-2">

        <!-- My hackathons list -->
        <div class="card">
          <div class="card-head">
            <span class="card-head-title">My Hackathons</span>
            <a href="/participant/my-hackathons" class="card-head-link">View all &rarr;</a>
          </div>
          <div class="card-body" style="padding-top:4px;padding-bottom:4px;">
            <!-- EL/JSTL kept exactly -->
            <c:choose>
              <c:when test="${empty myHackathons}">
                <div style="text-align:center;padding:28px 0;color:var(--text3);">
                  <svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom:8px;opacity:.35"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg>
                  <div style="font-size:13px;">You haven&#39;t joined any hackathons yet.</div>
                  <a href="/participant/home" style="display:inline-block;margin-top:8px;font-size:13px;font-weight:700;color:var(--accent);text-decoration:none;">Browse hackathons &rarr;</a>
                </div>
              </c:when>
              <c:otherwise>
                <c:forEach items="${myHackathons}" var="h" varStatus="i">
                  <c:if test="${i.index < 4}">
                    <div class="hack-item">
                      <div class="hack-thumb t${(i.index % 4) + 1}">&#127881;</div>
                      <div class="hack-info">
                        <div class="hack-title">${h.title}</div>
                        <div class="hack-meta">
                          <span>${h.eventType}</span>
                          <span>&bull;</span>
                          <span>${h.registrationEndDate}</span>
                        </div>
                      </div>
                      <c:choose>
                        <c:when test="${h.status == 'ONGOING'}"><span class="hack-badge badge-green">Live</span></c:when>
                        <c:when test="${h.status == 'UPCOMING'}"><span class="hack-badge badge-blue">Soon</span></c:when>
                        <c:otherwise><span class="hack-badge badge-grey">Done</span></c:otherwise>
                      </c:choose>
                    </div>
                  </c:if>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Activity / countdown -->
        <div style="display:flex;flex-direction:column;gap:16px;">

          <!-- Deadline countdown card -->
          <div class="card countdown-card">
            <div class="card-head">
              <span class="card-head-title">&#9201; Next Deadline</span>
              <a href="/participant/my-hackathons" class="card-head-link">View all</a>
            </div>
            <div class="countdown-banner">
              <div class="countdown-label">Submission closes in</div>
              <!-- EL kept: ${nextDeadlineHackathon} -->
              <div class="countdown-hack-name">${not empty nextDeadlineHackathon ? nextDeadlineHackathon.title : 'No active deadlines'}</div>
              <div class="countdown-timer" id="cd-timer">
                <div class="countdown-unit"><div class="countdown-num" id="cd-d">--</div><div class="countdown-unit-label">Days</div></div>
                <div class="countdown-sep">:</div>
                <div class="countdown-unit"><div class="countdown-num" id="cd-h">--</div><div class="countdown-unit-label">Hrs</div></div>
                <div class="countdown-sep">:</div>
                <div class="countdown-unit"><div class="countdown-num" id="cd-m">--</div><div class="countdown-unit-label">Min</div></div>
                <div class="countdown-sep">:</div>
                <div class="countdown-unit"><div class="countdown-num" id="cd-s">--</div><div class="countdown-unit-label">Sec</div></div>
              </div>
              <div class="countdown-note">Stay focused. Build something great.</div>
              <a href="/participant/my-hackathons" style="display:inline-flex;align-items:center;gap:6px;padding:9px 18px;background:#e8520a;color:#fff;border-radius:9px;font-size:13px;font-weight:700;text-decoration:none;">
                Go to Submission &rarr;
              </a>
            </div>
          </div>

          <!-- Quick actions -->
          <div class="card">
            <div class="card-head">
              <span class="card-head-title">Quick Actions</span>
            </div>
            <div class="card-body" style="display:flex;flex-direction:column;gap:8px;">
              <a href="/participant/home" style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;background:var(--bg);text-decoration:none;color:var(--text);font-size:13px;font-weight:600;transition:background .18s;" onmouseover="this.style.background='var(--bg2)'" onmouseout="this.style.background='var(--bg)'">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                Browse All Hackathons
              </a>
              <a href="/participant/my-hackathons" style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;background:var(--bg);text-decoration:none;color:var(--text);font-size:13px;font-weight:600;transition:background .18s;" onmouseover="this.style.background='var(--bg2)'" onmouseout="this.style.background='var(--bg)'">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="var(--blue)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>
                Manage My Team
              </a>
              <a href="/participant/profile" style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;background:var(--bg);text-decoration:none;color:var(--text);font-size:13px;font-weight:600;transition:background .18s;" onmouseover="this.style.background='var(--bg2)'" onmouseout="this.style.background='var(--bg)'">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="var(--green)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                Update My Profile
              </a>
            </div>
          </div>

        </div>
      </div>

      <!-- ── Explore Section ── -->
      <div class="section-row">
        <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:14px;">
          <div class="section-label">Explore Hackathons</div>
          <a href="/participant/home" style="font-size:13px;font-weight:600;color:var(--accent);text-decoration:none;">See all &rarr;</a>
        </div>
        <div class="explore-grid">
          <!-- EL/JSTL kept: ${allHackathons} or static demo if empty -->
          <c:choose>
            <c:when test="${not empty allHackathons}">
              <c:forEach items="${allHackathons}" var="h" varStatus="i">
                <c:if test="${i.index < 3}">
                  <div class="explore-card">
                    <div class="explore-banner b${(i.index % 3) + 1}">&#127881;</div>
                    <div class="explore-info">
                      <div class="explore-title">${h.title}</div>
                      <div class="explore-meta">
                        <span class="hack-badge ${h.status == 'ONGOING' ? 'badge-green' : h.status == 'UPCOMING' ? 'badge-blue' : 'badge-grey'}">${h.status}</span>
                        <span class="hack-badge badge-grey">${h.eventType}</span>
                      </div>
                      <div class="explore-footer">
                        <span class="explore-price ${h.payment == 'FREE' ? 'free' : 'paid'}">${h.payment == 'FREE' ? 'Free' : 'Paid'}</span>
                        <a href="/participant/hackathon/${h.hackathonId}" class="btn btn-primary" style="padding:7px 13px;font-size:12px;">View &rarr;</a>
                      </div>
                    </div>
                  </div>
                </c:if>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <!-- Placeholder cards when no data -->
              <div class="explore-card">
                <div class="explore-banner b1">&#128187;</div>
                <div class="explore-info">
                  <div class="explore-title">Web Dev Hackathon 2025</div>
                  <div class="explore-meta"><span class="hack-badge badge-green">ONGOING</span><span class="hack-badge badge-grey">ONLINE</span></div>
                  <div class="explore-footer"><span class="explore-price free">Free</span><a href="/participant/home" class="btn btn-primary" style="padding:7px 13px;font-size:12px;">View &rarr;</a></div>
                </div>
              </div>
              <div class="explore-card">
                <div class="explore-banner b2">&#129302;</div>
                <div class="explore-info">
                  <div class="explore-title">AI &amp; ML Sprint</div>
                  <div class="explore-meta"><span class="hack-badge badge-blue">UPCOMING</span><span class="hack-badge badge-grey">HYBRID</span></div>
                  <div class="explore-footer"><span class="explore-price free">Free</span><a href="/participant/home" class="btn btn-primary" style="padding:7px 13px;font-size:12px;">View &rarr;</a></div>
                </div>
              </div>
              <div class="explore-card">
                <div class="explore-banner b3">&#127758;</div>
                <div class="explore-info">
                  <div class="explore-title">Mobile App Challenge</div>
                  <div class="explore-meta"><span class="hack-badge badge-amber">UPCOMING</span><span class="hack-badge badge-grey">OFFLINE</span></div>
                  <div class="explore-footer"><span class="explore-price paid">Paid</span><a href="/participant/home" class="btn btn-primary" style="padding:7px 13px;font-size:12px;">View &rarr;</a></div>
                </div>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

    </div><!-- end .content -->

    <footer class="dash-footer">
      <span>&#169; 2025 Interns Coding for Hackathon &mdash; All rights reserved.</span>
      <span>Participant Portal v1.0</span>
    </footer>

  </div><!-- end .main -->
</div>

<script>
// ── Countdown timer (runs to a fixed date or from ${nextDeadlineHackathon.submissionDeadline}) ──
(function(){
  // Try to use EL-rendered deadline date, fall back to a demo target
  var rawDate = "${not empty nextDeadlineHackathon.submissionDeadline ? nextDeadlineHackathon.submissionDeadline : ''}";
  var target;
  if(rawDate && rawDate.trim() !== ''){
    target = new Date(rawDate);
    if(isNaN(target.getTime())) target = null;
  }
  if(!target){
    // Demo: 3 days from now
    target = new Date(Date.now() + 3 * 24 * 60 * 60 * 1000);
  }
  function pad(n){ return String(n).padStart(2,'0'); }
  function tick(){
    var now = Date.now();
    var diff = target.getTime() - now;
    if(diff <= 0){
      document.getElementById('cd-d').textContent='00';
      document.getElementById('cd-h').textContent='00';
      document.getElementById('cd-m').textContent='00';
      document.getElementById('cd-s').textContent='00';
      return;
    }
    var d = Math.floor(diff / 86400000);
    var h = Math.floor((diff % 86400000) / 3600000);
    var m = Math.floor((diff % 3600000) / 60000);
    var s = Math.floor((diff % 60000) / 1000);
    document.getElementById('cd-d').textContent = pad(d);
    document.getElementById('cd-h').textContent = pad(h);
    document.getElementById('cd-m').textContent = pad(m);
    document.getElementById('cd-s').textContent = pad(s);
  }
  tick();
  setInterval(tick, 1000);
})();
</script>
</body>
</html>
