/*======================================================================*\
|| #################################################################### ||
|| # Custom Forum Home - Foros del Web                                # ||
|| # @author      David Barrios <davidbarriosfdw@gmail.com            # ||
|| #################################################################### ||
\*======================================================================*/

var fdwMenus = {
	initialized: false,
	timer: 1000,
	hideTimer: null,
	init: function() {
		YAHOO.util.Event.on(document, "click", this.hide, this, true);
		this.initialized = true;
	},
	menus: [],
	register: function(id, side, altmenu, noclick) {
		if (!this.initialized) {
			this.init();
		}
		
		this.menus[id] = {};
		this.menus[id].id = id;
		this.menus[id].side = side;
		this.menus[id].button = document.getElementById(id);
		if (altmenu == undefined || altmenu === false) {
			this.menus[id].menu = document.getElementById(id + "_menu");
		} else {
			this.menus[id].menu = document.getElementById(altmenu + "_menu");
		}
		
		this.menus[id].menu.style.position = "absolute";
		
		if (noclick == undefined || noclick === false) {
			YAHOO.util.Event.on(this.menus[id].button, "click", this.click, this.menus[id], true);
		}
		YAHOO.util.Event.on(this.menus[id].button, "mouseover", this.mouseover, this.menus[id], true);
		YAHOO.util.Event.on(this.menus[id].button, "mouseout", this.menuLeave, this, true);
		
		if (!this.menus[id].menu.hookEvents) {
			this.menus[id].menu.hookEvents = true;
			YAHOO.util.Event.on(this.menus[id].menu, "mouseover", this.menuEnter, this, true);
			YAHOO.util.Event.on(this.menus[id].menu, "mouseout", this.menuLeave, this, true);
			YAHOO.util.Event.on(this.menus[id].menu, "click", function(E) { YAHOO.util.Event.stopPropagation(E); });
		}
	},
	click: function(E) {
		if (fdwMenus.active == this.id) {
			fdwMenus.hide();
		} else {
			fdwMenus.show(this.id);
		}
		YAHOO.util.Event.stopEvent(E);
	},
	menuEnter: function() {
		if (this.hideTimer) {
			clearTimeout(this.hideTimer);
		}
	},
	menuLeave: function() {
		this.hideTimer = setTimeout(this.hideFunc, this.timer);
	},
	mouseover: function(E) {
		fdwMenus.show(this.id);
	},
	show: function(menuid) {
		this.hide();
		this.menuEnter();
		
		var menu = this.menus[menuid];
		this.active = menuid;

		YAHOO.util.Dom.replaceClass(menu.button, "menulink", "menuactive")
		
		var buttonSize = YAHOO.util.Dom.getRegion(menu.button);
		menu.menu.style.display = "block";
		var menuSize = YAHOO.util.Dom.getRegion(menu.menu);
		
		if (menuSize.width < 150) {
			menu.menu.style.width = "150px";
			menuSize.width = 150;
		}
		if (menu.side == true) {
			var pos = [buttonSize.right - menuSize.width, buttonSize.bottom - 1];
		} else {
			var pos = [buttonSize.left, buttonSize.bottom - 1];
		}
		
		YAHOO.util.Dom.setXY(menu.menu, pos);
	},
	hide: function() {
		if (this.active === null) {
			return;
		}
		var menu = this.menus[this.active];

		YAHOO.util.Dom.replaceClass(menu.button, "menuactive", "menulink");
		menu.menu.style.display = "none";
		this.active = null;
	},
	hideFunc: function() {
		fdwMenus.hide();
	},
	active: null
};