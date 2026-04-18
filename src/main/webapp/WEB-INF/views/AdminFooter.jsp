<style>
.pc-footer{
  background:#ffffff;
  border-top:1px solid #e4e8f2;
  margin-top:auto;font-family:'Syne',sans-serif;
}
.footer-wrapper{padding:14px 28px}
.footer-wrapper .row{display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:8px}
.footer-wrapper .col-sm{flex:1;min-width:0}
.footer-wrapper .col-auto{flex-shrink:0}
.footer-wrapper p{margin:0;font-size:12px;color:#8a94b0;font-family:'Space Mono',monospace}
.footer-wrapper p a{color:#4f46e5;text-decoration:none;font-weight:700}
.footer-wrapper p a:hover{color:#4338ca}
.footer-link{list-style:none;margin:0;padding:0;display:flex;gap:16px}
.footer-link li a{font-size:12px;font-weight:600;font-family:'Space Mono',monospace;color:#8a94b0;text-decoration:none;transition:color .2s}
.footer-link li a:hover{color:#4f46e5}
.my-1{margin:4px 0 !important}
.m-0{margin:0 !important}
.list-inline{display:flex;gap:12px;list-style:none;padding:0;margin:0}
.list-inline-item{display:inline-block}
</style>

<footer class="pc-footer">
  <div class="footer-wrapper container-fluid">
    <div class="row">
      <div class="col-sm my-1">
        <p class="m-0">ICH &mdash; Interns Coding for Hackathon &#9829; Admin Panel</p>
      </div>
      <div class="col-auto my-1">
        <ul class="list-inline footer-link mb-0">
          <li class="list-inline-item"><a href="participant/home">Home</a></li>
        </ul>
      </div>
    </div>
  </div>
</footer>

<!-- Required JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="../assets/js/plugins/popper.min.js"></script>
<script src="../assets/js/plugins/bootstrap.min.js"></script>
<script src="../assets/js/plugins/simplebar.min.js"></script>
<script src="../assets/js/plugins/feather.min.js"></script>

<script>
try { layout_change && layout_change('light'); } catch(e){}
try { change_box_container && change_box_container('false'); } catch(e){}
try { layout_rtl_change && layout_rtl_change('false'); } catch(e){}
try { preset_change && preset_change("preset-1"); } catch(e){}

if (typeof font_change === "function") {
  try {
    font_change("Public-Sans");
  } catch (e) {
    console.warn("font_change skipped:", e.message);
  }
}
</script>
