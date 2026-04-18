<%-- AdminCSS.jsp : ICH Admin Panel - Light Professional Theme --%>
<!-- [Favicon] -->
<link rel="icon" href="../assets/images/favicon.svg" type="image/x-icon">
<!-- [Google Fonts] Syne + Space Mono -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap">
<!-- [Tabler Icons] -->
<link rel="stylesheet" href="../assets/fonts/tabler-icons.min.css">
<!-- [Feather Icons] -->
<link rel="stylesheet" href="../assets/fonts/feather.css">
<!-- [Font Awesome Icons] -->
<link rel="stylesheet" href="../assets/fonts/fontawesome.css">
<!-- [Material Icons] -->
<link rel="stylesheet" href="../assets/fonts/material.css">
<!-- [Template CSS Files] -->
<link rel="stylesheet" href="../assets/css/style.css" id="main-style-link">
<link rel="stylesheet" href="../assets/css/style-preset.css">

<style>
/* === ICH Admin - Light Professional Theme ================================ */
*,*::before,*::after{box-sizing:border-box}
:root{
  --bg:#f0f2f8;
  --surface:#ffffff;
  --surface2:#f7f8fc;
  --border:#e4e8f2;
  --border2:#cdd4e8;
  --accent:#4f46e5;
  --accent-pale:#eef2ff;
  --text:#1c2340;
  --text2:#4a5578;
  --muted:#8a94b0;
  --green:#15803d;
  --green-pale:#f0fdf4;
  --red:#b91c1c;
  --red-pale:#fef2f2;
  --amber:#b45309;
  --amber-pale:#fffbeb;
  --blue:#0369a1;
  --blue-pale:#f0f9ff;
  --radius:12px;
  --shadow:0 1px 6px rgba(28,35,64,.06);
  --shadow-md:0 4px 18px rgba(28,35,64,.09);
}
html,body{
  font-family:'Syne',sans-serif !important;
  background:var(--bg) !important;
  color:var(--text) !important;
  font-size:14px;line-height:1.6;
}
/* Layout */
.pc-container,.container-scroller{position:relative;z-index:1}
.pc-content,.content-wrapper{padding:24px 28px}
.main-panel{flex:1;min-width:0;display:flex;flex-direction:column}
.container-fluid.page-body-wrapper{display:flex;flex:1;margin-left:240px;transition:margin-left .25s;min-height:calc(100vh - 64px)}
/* Cards */
.card{background:var(--surface) !important;border:1px solid var(--border) !important;border-radius:var(--radius) !important;color:var(--text) !important;box-shadow:var(--shadow) !important}
.card-header{background:var(--surface2) !important;border-bottom:1px solid var(--border) !important;color:var(--text) !important;border-radius:var(--radius) var(--radius) 0 0 !important;padding:14px 20px !important;font-weight:700 !important}
.card-header.bg-dark,.card-header.bg-primary{background:var(--accent) !important;color:#fff !important}
.card-body{padding:20px !important}
.card-footer{background:var(--surface2) !important;border-top:1px solid var(--border) !important;padding:14px 20px !important;border-radius:0 0 var(--radius) var(--radius) !important}
.card-title{font-size:11px !important;font-family:'Space Mono',monospace !important;color:var(--muted) !important;letter-spacing:1.2px !important;text-transform:uppercase !important;font-weight:700 !important;margin:0 !important}
/* Tables */
.table{color:var(--text) !important;border-color:var(--border) !important}
.table th{font-family:'Space Mono',monospace !important;font-size:10px !important;letter-spacing:1px !important;text-transform:uppercase !important;color:var(--muted) !important;border-color:var(--border) !important;padding:11px 12px !important;background:var(--surface2) !important;font-weight:700 !important}
.table td{border-color:var(--border) !important;padding:11px 12px !important;font-size:13px !important;color:var(--text2) !important;vertical-align:middle !important}
.table tbody tr:hover td{background:var(--bg) !important}
.table-bordered{border:1px solid var(--border) !important}
.table-striped tbody tr:nth-of-type(odd){background:var(--bg) !important}
.table-hover tbody tr:hover{background:var(--bg) !important}
thead.table-dark th,.table-dark th{background:var(--accent) !important;color:#fff !important;border-color:var(--accent) !important}
thead.table-light th,thead.table-secondary th,.table-secondary th{background:var(--surface2) !important;color:var(--muted) !important}
/* Forms */
.form-control,.form-select,select.form-control,input.form-control,textarea.form-control{background:var(--surface) !important;border:1px solid var(--border2) !important;border-radius:9px !important;color:var(--text) !important;font-family:'Syne',sans-serif !important;font-size:13px !important;padding:9px 13px !important;transition:border-color .2s,box-shadow .2s !important}
.form-control:focus,.form-select:focus{border-color:var(--accent) !important;box-shadow:0 0 0 3px rgba(79,70,229,.12) !important;outline:none !important}
.form-control::placeholder{color:var(--muted) !important}
.form-label,label{color:var(--text2) !important;font-size:12px !important;font-weight:700 !important;text-transform:uppercase !important;letter-spacing:.4px !important;margin-bottom:6px !important}
.form-group{margin-bottom:16px !important}
.form-check-input{accent-color:var(--accent)}
.form-check-label{color:var(--text2) !important;font-size:13px !important;text-transform:none !important;letter-spacing:0 !important}
select option{background:var(--surface) !important;color:var(--text) !important}
textarea.form-control{height:auto !important;resize:vertical !important;padding:10px 13px !important}
/* Buttons */
.btn{border-radius:9px !important;font-family:'Syne',sans-serif !important;font-weight:700 !important;font-size:13px !important;transition:all .2s !important;padding:8px 16px !important}
.btn-primary{background:var(--accent) !important;border-color:var(--accent) !important;color:#fff !important}
.btn-primary:hover{background:#4338ca !important;transform:translateY(-1px) !important;box-shadow:0 4px 12px rgba(79,70,229,.3) !important}
.btn-secondary{background:var(--surface2) !important;border-color:var(--border2) !important;color:var(--text2) !important}
.btn-secondary:hover{background:var(--border) !important;color:var(--text) !important}
.btn-warning{background:#fef3c7 !important;border-color:#fbbf24 !important;color:#92400e !important}
.btn-warning:hover{background:#fde68a !important}
.btn-danger{background:var(--red-pale) !important;border-color:#fca5a5 !important;color:var(--red) !important}
.btn-danger:hover{background:#fee2e2 !important}
.btn-info{background:var(--blue-pale) !important;border-color:#7dd3fc !important;color:var(--blue) !important}
.btn-success{background:var(--green-pale) !important;border-color:#86efac !important;color:var(--green) !important}
.btn-outline-warning{border:1px solid #fbbf24 !important;color:#92400e !important;background:transparent !important}
.btn-outline-warning:hover{background:#fef3c7 !important}
.btn-outline-danger{border:1px solid #fca5a5 !important;color:var(--red) !important;background:transparent !important}
.btn-outline-danger:hover{background:var(--red-pale) !important}
.btn-sm{padding:5px 10px !important;font-size:12px !important}
/* Badges */
.badge{font-family:'Space Mono',monospace !important;font-size:10px !important;letter-spacing:.6px !important;border-radius:100px !important;padding:4px 9px !important;font-weight:700 !important}
.badge.bg-success,.badge.bg-light-success{background:var(--green-pale) !important;color:var(--green) !important;border:1px solid #86efac !important}
.badge.bg-danger,.badge.bg-light-danger{background:var(--red-pale) !important;color:var(--red) !important;border:1px solid #fca5a5 !important}
.badge.bg-warning{background:var(--amber-pale) !important;color:var(--amber) !important;border:1px solid #fcd34d !important}
.badge.bg-info{background:var(--blue-pale) !important;color:var(--blue) !important;border:1px solid #7dd3fc !important}
.badge.bg-primary,.badge.bg-light-primary{background:var(--accent-pale) !important;color:var(--accent) !important;border:1px solid #c4b5fd !important}
.badge.bg-secondary{background:var(--surface2) !important;color:var(--muted) !important;border:1px solid var(--border2) !important}
.rounded-pill{border-radius:100px !important}
/* Alerts */
.alert-success{background:var(--green-pale) !important;border-color:#86efac !important;color:var(--green) !important;border-radius:10px !important}
.alert-danger{background:var(--red-pale) !important;border-color:#fca5a5 !important;color:var(--red) !important;border-radius:10px !important}
.alert-warning{background:var(--amber-pale) !important;border-color:#fcd34d !important;color:var(--amber) !important;border-radius:10px !important}
.alert-info{background:var(--blue-pale) !important;border-color:#7dd3fc !important;color:var(--blue) !important;border-radius:10px !important}
.text-danger{color:var(--red) !important}
.text-success{color:var(--green) !important}
.text-muted{color:var(--muted) !important}
.text-info,.text-info:not(a){color:var(--blue) !important}
a.text-info{color:var(--accent) !important;text-decoration:none;font-size:12px;font-weight:700;font-family:'Space Mono',monospace}
/* Misc */
.label{font-weight:700 !important;color:var(--text2) !important;font-size:13px !important}
.html-box{background:var(--bg) !important;border:1px solid var(--border) !important;border-radius:10px !important;padding:14px !important;color:var(--text2) !important;line-height:1.8 !important}
.table-responsive{overflow-x:auto}
hr{border-color:var(--border) !important;margin:20px 0 !important}
h3,h4,h5,h6{color:var(--text) !important}
h5{font-size:14px !important;font-weight:800 !important}
.fw-semibold,.fw-bold{font-weight:700 !important}
.page-header{margin-bottom:22px}
.page-header h4{font-size:20px;font-weight:800;color:var(--text)}
.breadcrumb{background:transparent;padding:0;margin:0}
.breadcrumb-item{font-size:12px;color:var(--muted);font-family:'Space Mono',monospace}
.breadcrumb-item a{color:var(--muted);text-decoration:none}
.breadcrumb-item.active{color:var(--accent)}
.breadcrumb-item+.breadcrumb-item::before{color:var(--border2)}
.loader-bg{display:none}
::-webkit-scrollbar{width:5px;height:5px}
::-webkit-scrollbar-track{background:transparent}
::-webkit-scrollbar-thumb{background:var(--border2);border-radius:5px}
@media(max-width:992px){
  .container-fluid.page-body-wrapper{margin-left:0 !important}
  .pc-content,.content-wrapper{padding:16px !important}
}
</style>
