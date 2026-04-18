
<!-- [Favicon] -->
<link rel="icon" href="../assets/images/favicon.svg" type="image/x-icon">
<!-- [Google Fonts] -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" id="main-font-link">
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
/* ICH Participant — Dark Hackathon Theme */
*,*::before,*::after{box-sizing:border-box}
:root{
  --bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;
  --border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;
  --text:#e2e8f0;--muted:#64748b;
  --green:#4ade80;--amber:#fbbf24;--red:#f87171;
  --glow:rgba(124,58,237,.35);
}
html,body{
  font-family:'Syne',sans-serif !important;
  background:var(--bg) !important;
  color:var(--text) !important;
  font-size:14px;line-height:1.6;
}
body::before{
  content:'';position:fixed;inset:0;
  background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),
    linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);
  background-size:40px 40px;pointer-events:none;z-index:0;
}
.pc-container,.container-scroller{position:relative;z-index:1}
.pc-content,.content-wrapper{padding:24px 28px}
.main-panel{flex:1;min-width:0;display:flex;flex-direction:column}
.container-fluid.page-body-wrapper{display:flex;flex:1;margin-left:240px;transition:margin-left .25s}
/* Cards dark */
.card{background:var(--surface) !important;border:1px solid var(--border) !important;border-radius:14px !important;color:var(--text) !important}
.card-header{background:var(--surface2) !important;border-bottom:1px solid var(--border) !important;color:var(--text) !important;padding:14px 20px !important}
.card-body{padding:20px !important}
.card-footer{background:var(--surface2) !important;border-top:1px solid var(--border) !important;padding:14px 20px !important}
/* Forms dark */
.form-control,.form-select{background:var(--surface2) !important;border:1px solid var(--border) !important;border-radius:9px !important;color:var(--text) !important;font-family:'Syne',sans-serif !important;font-size:13px !important;padding:9px 13px !important}
.form-control:focus,.form-select:focus{border-color:var(--accent) !important;box-shadow:0 0 0 3px rgba(124,58,237,.15) !important}
.form-control::placeholder{color:var(--muted) !important}
.form-label,label{color:#8a9ab0 !important;font-size:11px !important;font-weight:700 !important;font-family:'Space Mono',monospace !important;letter-spacing:.5px !important;text-transform:uppercase !important;margin-bottom:6px !important}
.form-group{margin-bottom:16px !important}
/* Buttons dark */
.btn{border-radius:9px !important;font-family:'Syne',sans-serif !important;font-weight:700 !important;font-size:13px !important;transition:all .2s !important;padding:8px 16px !important}
.btn-primary{background:var(--accent) !important;border-color:var(--accent) !important;color:#fff !important}
.btn-primary:hover{background:#6d28d9 !important;transform:translateY(-1px) !important}
.btn-secondary{background:var(--surface2) !important;border-color:var(--border) !important;color:var(--muted) !important}
.btn-secondary:hover{color:var(--text) !important;border-color:var(--accent) !important}
.btn-warning{background:rgba(251,191,36,.12) !important;border-color:rgba(251,191,36,.3) !important;color:var(--amber) !important}
.btn-danger{background:rgba(248,113,113,.1) !important;border-color:rgba(248,113,113,.28) !important;color:var(--red) !important}
.btn-sm{padding:5px 10px !important;font-size:12px !important}
/* Badges dark */
.badge{font-family:'Space Mono',monospace !important;font-size:10px !important;letter-spacing:.6px !important;border-radius:100px !important;padding:4px 9px !important;font-weight:700 !important}
.badge.bg-success{background:rgba(74,222,128,.12) !important;color:var(--green) !important;border:1px solid rgba(74,222,128,.25) !important}
.badge.bg-danger{background:rgba(248,113,113,.1) !important;color:var(--red) !important;border:1px solid rgba(248,113,113,.25) !important}
.badge.bg-warning{background:rgba(251,191,36,.1) !important;color:var(--amber) !important;border:1px solid rgba(251,191,36,.25) !important}
.badge.bg-info{background:rgba(6,182,212,.1) !important;color:#67e8f9 !important;border:1px solid rgba(6,182,212,.22) !important}
.badge.bg-primary{background:rgba(124,58,237,.15) !important;color:#a78bfa !important;border:1px solid rgba(124,58,237,.28) !important}
/* Table dark */
.table{color:var(--text) !important;border-color:var(--border) !important}
.table th{font-family:'Space Mono',monospace !important;font-size:10px !important;letter-spacing:1px !important;text-transform:uppercase !important;color:var(--muted) !important;border-color:var(--border) !important;background:var(--surface2) !important;padding:11px !important}
.table td{border-color:var(--border) !important;padding:11px !important;font-size:13px !important;color:#b8c7d8 !important;vertical-align:middle !important}
.table tbody tr:hover td{background:rgba(124,58,237,.04) !important}
thead.table-dark th{background:var(--accent) !important;color:#fff !important}
/* Alerts dark */
.alert-success{background:rgba(74,222,128,.12) !important;border-color:rgba(74,222,128,.3) !important;color:var(--green) !important;border-radius:10px !important}
.alert-danger{background:rgba(248,113,113,.1) !important;border-color:rgba(248,113,113,.28) !important;color:var(--red) !important;border-radius:10px !important}
.alert-warning{background:rgba(251,191,36,.1) !important;border-color:rgba(251,191,36,.25) !important;color:var(--amber) !important;border-radius:10px !important}
.text-muted{color:var(--muted) !important}
.text-danger{color:var(--red) !important}
hr{border-color:var(--border) !important}
h3,h4,h5,h6{color:var(--text) !important}
.loader-bg{display:none}
::-webkit-scrollbar{width:5px;height:5px}
::-webkit-scrollbar-thumb{background:var(--border);border-radius:5px}
@media(max-width:992px){
  .container-fluid.page-body-wrapper{margin-left:0 !important}
  .pc-content,.content-wrapper{padding:16px !important}
}
</style>
