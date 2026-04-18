<style>
.pnav-header{
  position:sticky;top:0;z-index:120;
  background:rgba(10,10,15,.92);
  backdrop-filter:blur(20px);
  border-bottom:1px solid #2a2a3d;
  padding:0 28px;min-height:62px;
  display:flex;align-items:center;justify-content:space-between;gap:12px;
  font-family:'Syne',sans-serif;
}
.pnav-logo{
  display:flex;align-items:center;gap:10px;
  font-family:'Space Mono',monospace;font-size:16px;font-weight:700;
  color:#e2e8f0;text-decoration:none;
}
.pnav-logo-icon{
  width:34px;height:34px;
  background:linear-gradient(135deg,#7c3aed,#06b6d4);
  border-radius:9px;
  display:flex;align-items:center;justify-content:center;flex-shrink:0;
}
.pnav-logo-icon svg{display:block}
.pnav-links{
  display:flex;align-items:center;gap:6px;flex-wrap:wrap;
}
.pnav-links a{
  color:#64748b;text-decoration:none;font-size:13px;font-weight:600;
  padding:8px 14px;border-radius:9px;transition:all .18s;
}
.pnav-links a:hover{color:#e2e8f0;background:#1c1c27}
.pnav-primary{background:#7c3aed !important;color:#fff !important;box-shadow:0 2px 10px rgba(124,58,237,.3)}
.pnav-primary:hover{background:#6d28d9 !important;color:#fff !important}
@media(max-width:680px){
  .pnav-header{padding:0 14px}
  .pnav-logo span{display:none}
  .pnav-links a span{display:none}
  .pnav-links a{padding:8px 10px;font-size:12px}
}
</style>
<header class="pnav-header">
  <a class="pnav-logo" href="/participant/home">
    <div class="pnav-logo-icon">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
      </svg>
    </div>
    <span>INTERNS CODING FOR HACKATHON</span>
  </a>
  <nav class="pnav-links">
    <a href="/participant/home"><span>Explore</span></a>
    <a href="/participant/my-hackathons"><span>My Hackathons</span></a>
    <a href="/logout"><span>Logout</span></a>
    <a href="/participant/profile" class="pnav-primary"><span>My Profile</span></a>
  </nav>
</header>
