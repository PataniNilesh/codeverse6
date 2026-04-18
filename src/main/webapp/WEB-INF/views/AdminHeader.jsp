<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.pc-header{
  position:sticky;top:0;z-index:200;
  background:#ffffff;
  border-bottom:1px solid #e4e8f2;
  box-shadow:0 1px 6px rgba(28,35,64,.06);
  font-family:'Syne',sans-serif;
}
.header-wrapper{
  display:flex;align-items:center;height:62px;padding:0 24px;gap:10px;
}
.pc-mob-drp{display:flex;align-items:center;margin-right:auto}
.pc-mob-drp .list-unstyled,.ms-auto>.list-unstyled{
  list-style:none;margin:0;padding:0;display:flex;align-items:center;gap:4px;
}
.pc-head-link{
  display:inline-flex;align-items:center;justify-content:center;
  width:36px;height:36px;border-radius:9px;
  color:#8a94b0;text-decoration:none;background:transparent;
  border:none;cursor:pointer;transition:background .2s,color .2s;font-size:17px;
}
.pc-head-link:hover{background:#f0f2f8;color:#1c2340}
.pc-head-link.ms-0{margin-left:0 !important}
.pc-head-link.me-0{margin-right:0 !important}
.pc-head-link.bg-transparent{background:transparent !important}
.pc-sidebar-collapse{display:inline-flex}
.pc-sidebar-popup{display:none}
.header-search{
  display:flex;align-items:center;gap:10px;
  background:#f0f2f8;border:1px solid #e4e8f2;border-radius:10px;
  padding:0 14px;height:38px;transition:border-color .2s,box-shadow .2s;
}
.header-search:focus-within{border-color:#4f46e5;box-shadow:0 0 0 3px rgba(79,70,229,.1)}
.header-search .icon-search{color:#8a94b0;width:15px;height:15px;flex-shrink:0}
.header-search .form-control{
  border:none !important;background:transparent !important;
  color:#1c2340 !important;font-family:'Syne',sans-serif !important;
  font-size:14px !important;outline:none;width:180px;padding:0 !important;box-shadow:none !important;
}
.header-search .form-control::placeholder{color:#8a94b0 !important}
.ms-auto{margin-left:auto}
.d-none{display:none !important}
.d-md-inline-flex{display:inline-flex !important}
.d-inline-flex{display:inline-flex !important}
/* Dropdown */
.dropdown{position:relative}
.dropdown-menu{
  display:none;position:absolute;top:calc(100% + 8px);right:0;
  min-width:300px;background:#fff;border:1px solid #e4e8f2;
  border-radius:14px;box-shadow:0 10px 40px rgba(28,35,64,.12);
  z-index:400;overflow:hidden;
}
.dropdown-menu.show{display:block;animation:ddIn .15s ease}
@keyframes ddIn{from{opacity:0;transform:translateY(-6px)}to{opacity:1;transform:translateY(0)}}
.arrow-none::after,.arrow-none::before{display:none !important}
.dropdown-header{padding:14px 16px;border-bottom:1px solid #e4e8f2}
.dropdown-header h5{font-size:11px !important;font-weight:700 !important;font-family:'Space Mono',monospace !important;letter-spacing:1.5px !important;text-transform:uppercase !important;color:#8a94b0 !important;margin:0 !important}
.d-flex{display:flex !important}
.align-items-center{align-items:center !important}
.justify-content-between{justify-content:space-between !important}
.dropdown-divider{height:1px;background:#e4e8f2;margin:0}
.header-notification-scroll{max-height:280px;overflow-y:auto}
.list-group-flush .list-group-item,.list-group-item{
  display:block;padding:12px 16px;border-bottom:1px solid #f0f2f8;
  text-decoration:none;color:#4a5578;transition:background .15s;background:transparent;font-size:13px;
}
.list-group-item:last-child{border-bottom:none}
.list-group-item:hover{background:#f7f8fc}
.flex-shrink-0{flex-shrink:0}
.flex-grow-1{flex:1;min-width:0}
.ms-1{margin-left:6px}
.ms-3{margin-left:12px}
.mb-1{margin-bottom:4px !important}
.float-end{float:right}
.user-avtar{width:34px;height:34px;border-radius:9px;object-fit:cover;border:2px solid #e4e8f2}
.user-avtar.wid-35{width:35px;height:35px}
.text-danger{color:#b91c1c !important}
.text-center{text-align:center}
.py-2{padding:10px 0}
.link-primary{color:#4f46e5;font-size:12px;font-weight:700;text-decoration:none;font-family:'Space Mono',monospace}
.link-primary:hover{color:#4338ca}
/* User pill */
.header-user-profile .pc-head-link{
  width:auto;padding:6px 12px 6px 8px;gap:8px;border-radius:10px;
  border:1px solid #e4e8f2;background:#f7f8fc;color:#1c2340;
  font-size:13px;font-weight:700;
}
.header-user-profile .pc-head-link:hover{border-color:#4f46e5;background:#eef2ff}
.dropdown-user-profile{min-width:255px}
.dropdown-user-profile .dropdown-header{padding:16px}
.drp-tabs{list-style:none;margin:0;padding:8px 8px 0;display:flex;gap:4px;border-bottom:1px solid #e4e8f2;background:#fff}
.drp-tabs .nav-item{flex:1}
.drp-tabs .nav-link{
  display:flex;align-items:center;justify-content:center;gap:6px;
  width:100%;padding:8px 10px;border:none;background:transparent;
  border-radius:8px;color:#8a94b0;font-family:'Syne',sans-serif;
  font-size:12px;font-weight:700;cursor:pointer;transition:all .2s;
}
.drp-tabs .nav-link:hover{background:#f0f2f8;color:#1c2340}
.drp-tabs .nav-link.active{background:#eef2ff;color:#4f46e5}
.tab-content{padding:8px}
.tab-pane{display:none}
.tab-pane.show.active{display:block}
.dropdown-item{
  display:flex !important;align-items:center;gap:10px;
  padding:10px 12px !important;border-radius:9px !important;
  color:#4a5578 !important;font-size:13px !important;font-weight:600 !important;
  text-decoration:none;transition:background .15s;background:transparent !important;
  border:none;cursor:pointer;width:100%;font-family:'Syne',sans-serif !important;
}
.dropdown-item:hover{background:#f0f2f8 !important;color:#4f46e5 !important}
.dropdown-item i{font-size:15px;color:#8a94b0;flex-shrink:0}
.dropdown-item:hover i{color:#4f46e5}
.dropdown-notification{min-width:320px}
.text-body{color:#4a5578 !important}
@media(max-width:768px){
  .header-wrapper{padding:0 14px}
  .d-md-inline-flex{display:none !important}
  .pc-sidebar-collapse{display:none}
  .pc-sidebar-popup{display:inline-flex}
}
</style>

<header class="pc-header">
  <div class="header-wrapper">
    <div class="me-auto pc-mob-drp">
      <ul class="list-unstyled">
        <li class="pc-h-item pc-sidebar-collapse">
          <a href="#" class="pc-head-link ms-0" id="sidebar-hide">
            <i class="ti ti-menu-2"></i>
          </a>
        </li>
        <li class="pc-h-item pc-sidebar-popup">
          <a href="#" class="pc-head-link ms-0" id="mobile-collapse">
            <i class="ti ti-menu-2"></i>
          </a>
        </li>
        <li class="dropdown pc-h-item d-inline-flex d-md-none">
          <a class="pc-head-link dropdown-toggle arrow-none m-0" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
            <i class="ti ti-search"></i>
          </a>
          <div class="dropdown-menu pc-h-dropdown drp-search">
            <form class="px-3">
              <div class="form-group mb-0 d-flex align-items-center">
                <i data-feather="search"></i>
                <input type="search" class="form-control border-0 shadow-none" placeholder="Search here. . .">
              </div>
            </form>
          </div>
        </li>
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
        <li class="dropdown pc-h-item">
          <a class="pc-head-link dropdown-toggle arrow-none me-0" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
            <i class="ti ti-bell"></i>
          </a>
          <div class="dropdown-menu dropdown-notification dropdown-menu-end pc-h-dropdown">
            <div class="dropdown-header d-flex align-items-center justify-content-between">
              <h5 class="m-0">Notifications</h5>
              <a href="#!" class="pc-head-link bg-transparent"><i class="ti ti-x text-danger"></i></a>
            </div>
            <div class="dropdown-divider"></div>
            <div class="dropdown-header px-0 text-wrap header-notification-scroll" style="max-height:calc(100vh - 215px)">
              <div class="list-group list-group-flush w-100">
                <a class="list-group-item list-group-item-action">
                  <div class="d-flex">
                    <div class="flex-shrink-0"><img src="../assets/images/user/avatar-2.jpg" alt="user-image" class="user-avtar"></div>
                    <div class="flex-grow-1 ms-1"><span class="float-end text-muted">3:00 AM</span><p class="text-body mb-1">It's <b>Cristina danny's</b> birthday today.</p><span class="text-muted" style="font-size:12px">2 min ago</span></div>
                  </div>
                </a>
                <a class="list-group-item list-group-item-action">
                  <div class="d-flex">
                    <div class="flex-shrink-0"><img src="../assets/images/user/avatar-1.jpg" alt="user-image" class="user-avtar"></div>
                    <div class="flex-grow-1 ms-1"><span class="float-end text-muted">6:00 PM</span><p class="text-body mb-1"><b>Aida Burg</b> commented your post.</p><span class="text-muted" style="font-size:12px">5 August</span></div>
                  </div>
                </a>
              </div>
            </div>
            <div class="dropdown-divider"></div>
            <div class="text-center py-2"><a href="#!" class="link-primary">View all</a></div>
          </div>
        </li>
        <li class="dropdown pc-h-item header-user-profile">
          <a class="pc-head-link dropdown-toggle arrow-none me-0" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="false" data-bs-auto-close="outside" aria-expanded="false">
            <%-- EL kept exactly --%>
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
                  <c:if test="${not empty sessionScope.user.profilePicUrl}">
                    <img alt="user-image" src="${sessionScope.user.profilePicUrl}" class="user-avtar wid-35">
                  </c:if>
                  <c:if test="${empty sessionScope.user.profilePicUrl}">
                    <img src="../assets/images/user/avatar-2.jpg" alt="user-image" class="user-avtar wid-35">
                  </c:if>
                </div>
                <div class="flex-grow-1 ms-3">
                  <h6 class="mb-1" style="font-size:14px;font-weight:700;color:#1c2340">${sessionScope.user.firstName}</h6>
                  <p style="font-size:12px;color:#8a94b0;margin:0">Administrator</p>
                </div>
                <a href="logout" class="pc-head-link bg-transparent"><i class="ti ti-power text-danger"></i></a>
              </div>
            </div>
            <ul class="nav drp-tabs nav-fill nav-tabs" id="mydrpTab" role="tablist">
              <li class="nav-item" role="presentation">
                <button class="nav-link active" id="drp-t1" data-bs-toggle="tab" data-bs-target="#drp-tab-1" type="button" role="tab" aria-controls="drp-tab-1" aria-selected="true"><i class="ti ti-user"></i> Profile</button>
              </li>
              <li class="nav-item" role="presentation">
                <button class="nav-link" id="drp-t2" data-bs-toggle="tab" data-bs-target="#drp-tab-2" type="button" role="tab" aria-controls="drp-tab-2" aria-selected="false"><i class="ti ti-settings"></i> Setting</button>
              </li>
            </ul>
            <div class="tab-content" id="mysrpTabContent">
              <div class="tab-pane fade show active" id="drp-tab-1" role="tabpanel" tabindex="0">
                <a href="#!" class="dropdown-item"><i class="ti ti-edit-circle"></i><span>Edit Profile</span></a>
                <a href="#!" class="dropdown-item"><i class="ti ti-user"></i><span>View Profile</span></a>
                <a href="#!" class="dropdown-item"><i class="ti ti-clipboard-list"></i><span>Social Profile</span></a>
                <a href="logout" class="dropdown-item"><i class="ti ti-power"></i><span>Logout</span></a>
              </div>
              <div class="tab-pane fade" id="drp-tab-2" role="tabpanel" tabindex="0">
                <a href="#!" class="dropdown-item"><i class="ti ti-help"></i><span>Support</span></a>
                <a href="#!" class="dropdown-item"><i class="ti ti-user"></i><span>Account Settings</span></a>
                <a href="#!" class="dropdown-item"><i class="ti ti-lock"></i><span>Privacy Center</span></a>
                <a href="#!" class="dropdown-item"><i class="ti ti-messages"></i><span>Feedback</span></a>
                <a href="#!" class="dropdown-item"><i class="ti ti-list"></i><span>History</span></a>
              </div>
            </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</header>
