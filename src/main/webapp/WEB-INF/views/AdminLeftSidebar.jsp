<style>
.pc-sidebar{
  position:fixed;top:62px;left:0;width:240px;
  height:calc(100vh - 62px);
  background:#ffffff;
  border-right:1px solid #e4e8f2;
  box-shadow:2px 0 8px rgba(28,35,64,.04);
  overflow-y:auto;overflow-x:hidden;
  z-index:100;display:flex;flex-direction:column;
  transition:width .25s ease,transform .25s ease;
  font-family:'Syne',sans-serif;
}
.pc-sidebar::-webkit-scrollbar{width:3px}
.pc-sidebar::-webkit-scrollbar-thumb{background:#e4e8f2;border-radius:3px}
.navbar-wrapper{display:flex;flex-direction:column;height:100%;padding-bottom:20px}
.m-header{padding:18px 20px 14px;border-bottom:1px solid #e4e8f2;flex-shrink:0}
.b-brand{display:flex;align-items:center;gap:10px;text-decoration:none}
.b-brand .brand-icon-wrap{
  width:34px;height:34px;background:#4f46e5;border-radius:9px;
  display:flex;align-items:center;justify-content:center;flex-shrink:0;
}
.b-brand .brand-icon-wrap svg{display:block}
.b-brand .brand-name{font-family:'Syne',sans-serif;font-size:14px;font-weight:800;color:#1c2340;line-height:1.2}
.b-brand .brand-sub{font-size:9px;font-weight:700;color:#8a94b0;letter-spacing:.8px;text-transform:uppercase}
.b-brand .img-fluid{height:26px;width:auto;display:none}
.navbar-content{flex:1;padding:10px 0}
.pc-navbar{list-style:none;margin:0;padding:0}
.pc-item.pc-caption{padding:14px 20px 5px}
.pc-item.pc-caption label{font-family:'Space Mono',monospace;font-size:9px;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:#8a94b0;cursor:default}
.pc-item.pc-caption i{display:none}
.pc-item{position:relative}
.pc-link{
  display:flex;align-items:center;gap:10px;
  padding:10px 20px;color:#4a5578;
  text-decoration:none;font-size:13px;font-weight:600;
  transition:all .18s;
  cursor:pointer;
  user-select:none;
}
.pc-link:hover{color:#4f46e5;background:#eef2ff;padding-left:24px}
.pc-item.active>.pc-link{color:#4f46e5;background:#eef2ff;font-weight:700;border-right:2px solid #4f46e5}
.pc-micon{width:18px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.pc-micon i{font-size:16px}
.pc-mtext{flex:1}
.pc-arrow{
  margin-left:auto;
  display:flex;align-items:center;
  color:#8a94b0;
  transition:transform .25s ease;
  flex-shrink:0;
}
/* Arrow rotates when menu is open */
.pc-item.pc-hasmenu.pc-trigger > .pc-link .pc-arrow{
  transform:rotate(90deg);
  color:#4f46e5;
}
/* Submenu hidden by default */
.pc-submenu{
  list-style:none;margin:0;padding:0;
  display:none;
  background:#fafbfd;
  border-left:2px solid #e4e8f2;
  margin-left:30px;
  overflow:hidden;
}
/* Submenu shown when parent has pc-trigger */
.pc-item.pc-hasmenu.pc-trigger > .pc-submenu{
  display:block;
}
.pc-submenu .pc-item .pc-link{font-size:12px;font-weight:600;color:#8a94b0;padding:8px 14px}
.pc-submenu .pc-item .pc-link:hover{color:#4f46e5;background:#eef2ff;padding-left:18px}
/* Promo card */
.navbar-content>.card{
  margin:14px 12px 0;
  background:linear-gradient(135deg,#eef2ff,#f0f9ff) !important;
  border:1px solid #c7d2fe !important;
  border-radius:12px !important;
  text-align:center;padding:16px 12px;
  box-shadow:none !important;
}
.navbar-content>.card .card-body{padding:0 !important}
.navbar-content>.card .img-fluid{width:60px;margin-bottom:10px}
.navbar-content>.card h5{font-size:13px !important;font-weight:800 !important;color:#1c2340 !important;margin-bottom:5px !important}
.navbar-content>.card p{font-size:12px !important;color:#8a94b0 !important;margin-bottom:10px !important;line-height:1.5 !important}
.navbar-content>.card .btn-success{
  display:inline-block;background:#4f46e5 !important;color:#fff !important;
  border:none !important;border-radius:8px !important;
  padding:7px 16px !important;font-size:12px !important;font-weight:700 !important;
  text-decoration:none !important;cursor:pointer !important;
}
.navbar-content>.card .btn-success:hover{background:#4338ca !important}
.container-fluid.page-body-wrapper{margin-left:240px;transition:margin-left .25s ease}
@media(max-width:992px){
  .pc-sidebar{transform:translateX(-100%);top:0;height:100vh;z-index:500}
  .pc-sidebar.mob-sidebar-active{transform:translateX(0)}
  .container-fluid.page-body-wrapper{margin-left:0 !important}
}
</style>

<nav class="pc-sidebar" id="ich-sidebar">
  <div class="navbar-wrapper">
    <div class="m-header">
      <a href="admin-dashboard" class="b-brand">
        <div class="brand-icon-wrap">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
          </svg>
        </div>
        <div>
          <div class="brand-name">ICH Admin</div>
          <div class="brand-sub">Interns Coding</div>
        </div>
      </a>
    </div>
    <div class="navbar-content">
      <ul class="pc-navbar" id="ich-navbar">

        <li class="pc-item">
          <a href="admin-dashboard" class="pc-link">
            <span class="pc-micon"><i class="ti ti-layout-dashboard"></i></span>
            <span class="pc-mtext">Dashboard</span>
          </a>
        </li>

        <li class="pc-item pc-caption">
          <label>Management</label>
        </li>

        <!-- Manage Users -->
        <li class="pc-item pc-hasmenu" id="menu-users">
          <a href="#" class="pc-link ich-menu-trigger" data-target="menu-users">
            <span class="pc-micon"><i class="ti ti-users"></i></span>
            <span class="pc-mtext">Manage Users</span>
            <span class="pc-arrow">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
            </span>
          </a>
          <ul class="pc-submenu">
            <li class="pc-item"><a class="pc-link" href="newUserType">Add New User</a></li>
            <li class="pc-item"><a class="pc-link" href="listuser">User List</a></li>
          </ul>
        </li>

        <!-- Category -->
        <li class="pc-item pc-hasmenu" id="menu-category">
          <a href="#" class="pc-link ich-menu-trigger" data-target="menu-category">
            <span class="pc-micon"><i class="ti ti-tag"></i></span>
            <span class="pc-mtext">Category</span>
            <span class="pc-arrow">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
            </span>
          </a>
          <ul class="pc-submenu">
            <li class="pc-item"><a class="pc-link" href="newCategory">Add New Category</a></li>
            <li class="pc-item"><a class="pc-link" href="listCategory">List Category</a></li>
          </ul>
        </li>

        <!-- Hackathon -->
        <li class="pc-item pc-hasmenu" id="menu-hackathon">
          <a href="#" class="pc-link ich-menu-trigger" data-target="menu-hackathon">
            <span class="pc-micon"><i class="ti ti-bolt"></i></span>
            <span class="pc-mtext">Hackathon</span>
            <span class="pc-arrow">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
            </span>
          </a>
          <ul class="pc-submenu">
            <li class="pc-item"><a class="pc-link" href="newHackathon">Add New Hackathon</a></li>
            <li class="pc-item"><a class="pc-link" href="listHackathon">List Hackathon</a></li>
          </ul>
        </li>

        <!-- Judges -->
        <li class="pc-item pc-hasmenu" id="menu-judges">
          <a href="#" class="pc-link ich-menu-trigger" data-target="menu-judges">
            <span class="pc-micon"><i class="ti ti-award"></i></span>
            <span class="pc-mtext">Judges</span>
            <span class="pc-arrow">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
            </span>
          </a>
          <ul class="pc-submenu">
            <li class="pc-item"><a class="pc-link" href="newJudge">Invite Judge</a></li>
            <li class="pc-item"><a class="pc-link" href="listJudge">Judge List</a></li>
          </ul>
        </li>

      </ul>

      <div class="card">
        <div class="card-body">
          <img src="../assets/images/img-navbar-card.png" alt="images" class="img-fluid mb-2">
          <h5>ICH Platform</h5>
          <p>Interns Coding for Hackathon &mdash; Admin Panel</p>
          <a href="admin-dashboard" class="btn btn-success">Dashboard</a>
        </div>
      </div>

    </div>
  </div>
</nav>

<%-- ══ Sidebar JS ═══════════════════════════════════════════════════════════
     Uses DOMContentLoaded so it always runs AFTER the full page is parsed,
     regardless of where in the JSP include chain this fragment appears.
══════════════════════════════════════════════════════════════════════════ --%>
<script>
(function () {
  function initSidebar() {
    /* ── Submenu toggle ── */
    var triggers = document.querySelectorAll('.ich-menu-trigger');
    triggers.forEach(function (link) {
      link.addEventListener('click', function (e) {
        e.preventDefault();
        var item = this.closest('.pc-hasmenu');
        if (!item) return;

        var isOpen = item.classList.contains('pc-trigger');

        /* Close all open menus */
        document.querySelectorAll('.pc-hasmenu.pc-trigger').forEach(function (el) {
          el.classList.remove('pc-trigger');
        });

        /* Open this one if it was closed */
        if (!isOpen) {
          item.classList.add('pc-trigger');
        }
      });
    });

    /* ── Mobile toggle (hamburger button in header) ── */
    var sidebar     = document.getElementById('ich-sidebar');
    var mobileBtn   = document.getElementById('mobile-collapse');
    var desktopBtn  = document.getElementById('sidebar-hide');

    if (mobileBtn && sidebar) {
      mobileBtn.addEventListener('click', function (e) {
        e.preventDefault();
        sidebar.classList.toggle('mob-sidebar-active');
      });
    }
    if (desktopBtn && sidebar) {
      desktopBtn.addEventListener('click', function (e) {
        e.preventDefault();
        sidebar.classList.toggle('pc-sidebar-hide');
      });
    }

    /* ── Auto-open submenu for active page ── */
    var currentPath = window.location.pathname.split('/').pop() || '';
    document.querySelectorAll('.pc-submenu .pc-link').forEach(function (link) {
      var href = (link.getAttribute('href') || '').split('?')[0];
      if (href && currentPath && currentPath === href) {
        link.classList.add('active');
        var parentMenu = link.closest('.pc-hasmenu');
        if (parentMenu) parentMenu.classList.add('pc-trigger');
      }
    });

    /* ── Feather icons (safe call — only if library is loaded) ── */
    if (typeof feather !== 'undefined') feather.replace();
  }

  /* Run after full DOM is ready — works whether script is in <head> or <body> */
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initSidebar);
  } else {
    /* DOM already parsed (script ran after closing </body>) */
    initSidebar();
  }
})();
</script>
