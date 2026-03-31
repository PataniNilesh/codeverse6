<style>
.pnav-header {
	position: sticky;
	top: 0;
	z-index: 120;
	background: rgba(10, 10, 15, 0.88);
	backdrop-filter: blur(20px);
	border-bottom: 1px solid #2a2a3d;
	padding: 0 24px;
	min-height: 64px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 12px;
}
.pnav-logo {
	display: flex;
	align-items: center;
	gap: 10px;
	font-family: 'Space Mono', monospace;
	font-size: 18px;
	font-weight: 700;
	color: #e2e8f0;
	text-decoration: none;
}
.pnav-logo-icon {
	width: 34px;
	height: 34px;
	background: linear-gradient(135deg, #7c3aed, #06b6d4);
	border-radius: 8px;
	display: flex;
	align-items: center;
	justify-content: center;
}
.pnav-links {
	display: flex;
	align-items: center;
	gap: 8px;
	flex-wrap: wrap;
	justify-content: flex-end;
}
.pnav-links a {
	color: #64748b;
	text-decoration: none;
	font-size: 14px;
	font-weight: 600;
	padding: 8px 14px;
	border-radius: 8px;
	transition: all 0.2s;
}
.pnav-links a:hover {
	color: #e2e8f0;
	background: #1c1c27;
}
.pnav-links .pnav-primary {
	background: #7c3aed;
	color: #fff;
}
.pnav-links .pnav-primary:hover {
	background: #6d28d9;
}
@media (max-width: 760px) {
	.pnav-header {
		padding: 10px 14px;
	}
	.pnav-logo {
		font-size: 16px;
	}
}
</style>

<header class="pnav-header">
	<a class="pnav-logo" href="/participant/home">
		<div class="pnav-logo-icon">
			<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5"
				stroke-linecap="round" stroke-linejoin="round">
				<polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2" />
			</svg>
		</div>
		HackPortal
	</a>
	<nav class="pnav-links">
		<a href="/participant/home">Explore</a>
		<a href="/participant/my-hackathons">My Hackathons</a>
		<a href="/logout">Logout</a>
		<a href="/participant/profile" class="pnav-primary">My Profile</a>
	</nav>