<style>
.pc-sidebar{position:fixed;top:62px;left:0;width:240px;height:calc(100vh - 62px);background:#0d0d14;border-right:1px solid #2a2a3d;overflow-y:auto;overflow-x:hidden;z-index:100;display:flex;flex-direction:column;transition:width .25s ease,transform .25s ease;font-family:'Syne',sans-serif}
.pc-sidebar::-webkit-scrollbar{width:3px}
.pc-sidebar::-webkit-scrollbar-thumb{background:#2a2a3d;border-radius:3px}
.navbar-wrapper{display:flex;flex-direction:column;height:100%;padding-bottom:20px}
.m-header{padding:18px 20px 14px;border-bottom:1px solid #2a2a3d;flex-shrink:0}
.b-brand{display:flex;align-items:center;gap:10px;text-decoration:none}
.b-brand .brand-icon-wrap{width:34px;height:34px;background:#7c3aed;border-radius:9px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.b-brand .brand-name{font-family:'Space Mono',monospace;font-size:14px;font-weight:700;color:#e2e8f0;line-height:1.2}
.b-brand .brand-sub{font-size:9px;font-weight:700;color:#64748b;letter-spacing:.8px;text-transform:uppercase}
.navbar-content{flex:1;padding:10px 0}
.pc-navbar{list-style:none;margin:0;padding:0}
.pc-item.pc-caption{padding:14px 20px 5px}
.pc-item.pc-caption label{font-family:'Space Mono',monospace;font-size:9px;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:#64748b;cursor:default}
.pc-item.pc-caption i{display:none}
.pc-item{position:relative}
.pc-link{display:flex;align-items:center;gap:10px;padding:10px 20px;color:#64748b;text-decoration:none;font-size:13px;font-weight:600;transition:all .18s}
.pc-link:hover{color:#e2e8f0;background:rgba(124,58,237,.1);padding-left:24px}
.pc-item.active>.pc-link{color:#a78bfa;background:rgba(124,58,237,.15);border-right:2px solid #7c3aed;font-weight:700}
.pc-micon{width:18px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.pc-micon i{font-size:16px}
.pc-mtext{flex:1}
.pc-arrow{margin-left:auto;display:flex;align-items:center;color:#64748b;transition:transform .25s}
.pc-item.pc-hasmenu.pc-trigger>.pc-link .pc-arrow{transform:rotate(90deg)}
.pc-submenu{list-style:none;margin:0;padding:0;display:none;background:rgba(0,0,0,.2);border-left:2px solid #2a2a3d;margin-left:28px}
.pc-item.pc-hasmenu.pc-trigger>.pc-submenu{display:block}
.pc-submenu .pc-item .pc-link{font-size:12px;font-weight:600;color:#64748b;padding:8px 14px}
.pc-submenu .pc-item .pc-link:hover{color:#a78bfa;background:rgba(124,58,237,.08);padding-left:18px}
.container-fluid.page-body-wrapper{margin-left:240px;transition:margin-left .25s ease}
@media(max-width:992px){.pc-sidebar{transform:translateX(-100%);top:0;height:100vh;z-index:500}.pc-sidebar.mob-sidebar-active{transform:translateX(0)}.container-fluid.page-body-wrapper{margin-left:0!important}}
</style>

<nav class="pc-sidebar">
  <div class="navbar-wrapper">
    <div class="m-header">
      <a href="admin-dashboard" class="b-brand">
        <div class="brand-icon-wrap">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
        </div>
        <div>
          <div class="brand-name">ICH Portal</div>
          <div class="brand-sub">Participant</div>
        </div>
      </a>
    </div>
    <div class="navbar-content">
      <ul class="pc-navbar">
        <li class="pc-item pc-caption"><label>Main</label></li>
        <li class="pc-item"><a href="admin-dashboard" class="pc-link"><span class="pc-micon"><i class="ti ti-layout-dashboard"></i></span><span class="pc-mtext">Dashboard</span></a></li>
        <li class="pc-item pc-hasmenu">
          <a href="#!" class="pc-link"><span class="pc-micon"><i class="ti ti-bolt"></i></span><span class="pc-mtext">Hackathons</span><span class="pc-arrow"><i data-feather="chevron-right"></i></span></a>
          <ul class="pc-submenu">
            <li class="pc-item"><a href="newUserType" class="pc-link">Explore</a></li>
            <li class="pc-item"><a href="listuser" class="pc-link">My Hackathons</a></li>
          </ul>
        </li>
        <li class="pc-item pc-caption"><label>Account</label></li>
        <li class="pc-item"><a href="newCategory" class="pc-link"><span class="pc-micon"><i class="ti ti-user"></i></span><span class="pc-mtext">My Profile</span></a></li>
        <li class="pc-item"><a href="listCategory" class="pc-link"><span class="pc-micon"><i class="ti ti-logout"></i></span><span class="pc-mtext">Logout</span></a></li>
      </ul>
    </div>
  </div>
</nav>
