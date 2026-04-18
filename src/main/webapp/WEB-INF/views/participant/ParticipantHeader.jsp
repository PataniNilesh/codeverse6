<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.pc-header{position:sticky;top:0;z-index:200;background:rgba(10,10,15,.92);backdrop-filter:blur(20px);border-bottom:1px solid #2a2a3d;font-family:'Syne',sans-serif}
.header-wrapper{display:flex;align-items:center;height:62px;padding:0 24px;gap:10px}
.pc-mob-drp{display:flex;align-items:center;margin-right:auto}
.pc-mob-drp .list-unstyled,.ms-auto>.list-unstyled{list-style:none;margin:0;padding:0;display:flex;align-items:center;gap:4px}
.pc-head-link{display:inline-flex;align-items:center;justify-content:center;width:36px;height:36px;border-radius:9px;color:#64748b;text-decoration:none;background:transparent;border:none;cursor:pointer;transition:background .2s,color .2s;font-size:17px}
.pc-head-link:hover{background:#1c1c27;color:#e2e8f0}
.pc-head-link.ms-0{margin-left:0!important}
.pc-head-link.me-0{margin-right:0!important}
.pc-head-link.bg-transparent{background:transparent!important}
.pc-sidebar-collapse{display:inline-flex}
.pc-sidebar-popup{display:none}
.header-search{display:flex;align-items:center;gap:10px;background:#13131a;border:1px solid #2a2a3d;border-radius:10px;padding:0 14px;height:38px;transition:border-color .2s,box-shadow .2s}
.header-search:focus-within{border-color:#7c3aed;box-shadow:0 0 0 3px rgba(124,58,237,.15)}
.header-search .icon-search{color:#64748b;width:15px;height:15px;flex-shrink:0}
.header-search .form-control{border:none!important;background:transparent!important;color:#e2e8f0!important;font-family:'Syne',sans-serif!important;font-size:14px!important;outline:none;width:180px;padding:0!important;box-shadow:none!important}
.header-search .form-control::placeholder{color:#64748b!important}
.ms-auto{margin-left:auto}
.d-none{display:none!important}
.d-md-inline-flex{display:inline-flex!important}
.d-inline-flex{display:inline-flex!important}
.dropdown{position:relative}
.dropdown-menu{display:none;position:absolute;top:calc(100% + 8px);right:0;min-width:300px;background:#13131a;border:1px solid #2a2a3d;border-radius:14px;box-shadow:0 12px 40px rgba(0,0,0,.5);z-index:400;overflow:hidden}
.dropdown-menu.show{display:block;animation:ddIn .15s ease}
@keyframes ddIn{from{opacity:0;transform:translateY(-6px)}to{opacity:1;transform:translateY(0)}}
.arrow-none::after,.arrow-none::before{display:none!important}
.dropdown-header{padding:14px 16px;border-bottom:1px solid #2a2a3d}
.dropdown-header h5{font-size:11px!important;font-weight:700!important;font-family:'Space Mono',monospace!important;letter-spacing:1.5px!important;text-transform:uppercase!important;color:#64748b!important;margin:0!important}
.d-flex{display:flex!important}
.align-items-center{align-items:center!important}
.justify-content-between{justify-content:space-between!important}
.dropdown-divider{height:1px;background:#2a2a3d;margin:0}
.header-notification-scroll{max-height:280px;overflow-y:auto}
.list-group-flush .list-group-item,.list-group-item{display:block;padding:12px 16px;border-bottom:1px solid #1c1c27;text-decoration:none;color:#94a3b8;transition:background .15s;background:transparent;font-size:13px}
.list-group-item:last-child{border-bottom:none}
.list-group-item:hover{background:#1c1c27}
.flex-shrink-0{flex-shrink:0}
.flex-grow-1{flex:1;min-width:0}
.ms-1{margin-left:6px}
.ms-3{margin-left:12px}
.mb-1{margin-bottom:4px!important}
.float-end{float:right}
.user-avtar{width:34px;height:34px;border-radius:9px;object-fit:cover;border:1px solid #2a2a3d}
.user-avtar.wid-35{width:35px;height:35px}
.text-danger{color:#f87171!important}
.text-center{text-align:center}
.py-2{padding:10px 0}
.link-primary{color:#a78bfa;font-size:12px;font-weight:700;text-decoration:none;font-family:'Space Mono',monospace}
.header-user-profile .pc-head-link{width:auto;padding:6px 12px 6px 8px;gap:8px;border-radius:10px;border:1px solid #2a2a3d;background:#13131a;color:#e2e8f0;font-size:13px;font-weight:700}
.header-user-profile .pc-head-link:hover{border-color:#7c3aed;background:#1c1c27}
.dropdown-user-profile{min-width:255px}
.dropdown-user-profile .dropdown-header{padding:16px}
.drp-tabs{list-style:none;margin:0;padding:8px 8px 0;display:flex;gap:4px;border-bottom:1px solid #2a2a3d;background:#13131a}
.drp-tabs .nav-item{flex:1}
.drp-tabs .nav-link{display:flex;align-items:center;justify-content:center;gap:6px;width:100%;padding:8px 10px;border:none;background:transparent;border-radius:8px;color:#64748b;font-family:'Syne',sans-serif;font-size:12px;font-weight:700;cursor:pointer;transition:all .2s}
.drp-tabs .nav-link:hover{background:#1c1c27;color:#e2e8f0}
.drp-tabs .nav-link.active{background:rgba(124,58,237,.18);color:#a78bfa}
.tab-content{padding:8px}
.tab-pane{display:none}
.tab-pane.show.active{display:block}
.dropdown-item{display:flex!important;align-items:center;gap:10px;padding:10px 12px!important;border-radius:9px!important;color:#94a3b8!important;font-size:13px!important;font-weight:600!important;text-decoration:none;transition:background .15s;background:transparent!important;border:none;cursor:pointer;width:100%;font-family:'Syne',sans-serif!important}
.dropdown-item:hover{background:#1c1c27!important;color:#a78bfa!important}
.dropdown-item i{font-size:15px;color:#64748b;flex-shrink:0}
.dropdown-item:hover i{color:#a78bfa}
.text-body{color:#94a3b8!important}
</style>

<header class="pc-header">
  <div class="header-wrapper">
    <div class="me-auto pc-mob-drp">
      <ul class="list-unstyled">
        <li class="pc-h-item pc-sidebar-collapse"><a href="#" class="pc-head-link ms-0" id="sidebar-hide"><i class="ti ti-menu-2"></i></a></li>
        <li class="pc-h-item pc-sidebar-popup"><a href="#" class="pc-head-link ms-0" id="mobile-collapse"><i class="ti ti-menu-2"></i></a></li>
        <li class="pc-h-item d-none d-md-inline-flex">
          <form class="header-search">
            <i data-feather="search" class="icon-search"></i>
            <input type="search" class="form-control" placeholder="Search here. . .">
          </form>
        </li>
      </ul>
    </div>
    <div class="ms-auto">
      <ul class="list-unstyled">
        <li class="dropdown pc-h-item header-user-profile">
          <a class="pc-head-link dropdown-toggle arrow-none me-0" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="false" data-bs-auto-close="outside" aria-expanded="false">
            <c:if test="${not empty sessionScope.user.profilePicUrl}">
              <img alt="user-image" src="${sessionScope.user.profilePicUrl}" class="user-avtar">
            </c:if>
            <c:if test="${empty sessionScope.user.profilePicUrl}">
              <img src="../assets/images/user/avatar-2.jpg" alt="user-image" class="user-avtar">
            </c:if>
            <span>${sessionScope.user.firstName}</span>
          </a>
          <div class="dropdown-menu dropdown-user-profile dropdown-menu-end pc-h-dropdown">
            <div class="dropdown-header">
              <div class="d-flex mb-1">
                <div class="flex-shrink-0">
                  <c:if test="${not empty sessionScope.user.profilePicUrl}"><img alt="user-image" src="${sessionScope.user.profilePicUrl}" class="user-avtar wid-35"></c:if>
                  <c:if test="${empty sessionScope.user.profilePicUrl}"><img src="../assets/images/user/avatar-2.jpg" alt="user-image" class="user-avtar wid-35"></c:if>
                </div>
                <div class="flex-grow-1 ms-3">
                  <h6 class="mb-1" style="font-size:14px;font-weight:700;color:#e2e8f0">${sessionScope.user.firstName}</h6>
                  <p style="font-size:12px;color:#64748b;margin:0">Participant</p>
                </div>
                <a href="logout" class="pc-head-link bg-transparent"><i class="ti ti-power text-danger"></i></a>
              </div>
            </div>
            <ul class="nav drp-tabs nav-fill nav-tabs" id="mydrpTab" role="tablist">
              <li class="nav-item"><button class="nav-link active" id="drp-t1" data-bs-toggle="tab" data-bs-target="#drp-tab-1" type="button" role="tab"><i class="ti ti-user"></i> Profile</button></li>
              <li class="nav-item"><button class="nav-link" id="drp-t2" data-bs-toggle="tab" data-bs-target="#drp-tab-2" type="button" role="tab"><i class="ti ti-settings"></i> Setting</button></li>
            </ul>
            <div class="tab-content" id="mysrpTabContent">
              <div class="tab-pane fade show active" id="drp-tab-1" role="tabpanel" tabindex="0">
                <a href="#!" class="dropdown-item"><i class="ti ti-edit-circle"></i><span>Edit Profile</span></a>
                <a href="#!" class="dropdown-item"><i class="ti ti-user"></i><span>View Profile</span></a>
                <a href="logout" class="dropdown-item"><i class="ti ti-power"></i><span>Logout</span></a>
              </div>
              <div class="tab-pane fade" id="drp-tab-2" role="tabpanel" tabindex="0">
                <a href="#!" class="dropdown-item"><i class="ti ti-help"></i><span>Support</span></a>
                <a href="#!" class="dropdown-item"><i class="ti ti-lock"></i><span>Privacy Center</span></a>
                <a href="#!" class="dropdown-item"><i class="ti ti-messages"></i><span>Feedback</span></a>
              </div>
            </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</header>
