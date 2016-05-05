
(function($) {

	var Thermometer = {

		/** 
		 *  Set the value to show in the thermometer. If the value
		 *  is outside the maxmimum or minimum range it shall be clipped.
		 */
		setValue: function( value ) {
			if( value >= this.options.maxValue ) {
				this.valueToAttain = this.options.maxValue;
			} else if( value <= this.options.minValue ) {
				this.valueToAttain = this.options.minValue;
			} else {
				this.valueToAttain = value;
			}

			this._update();
		},

		/**
		 * Set the text at the top of the scale
		 */
		setTopText: function( newText ) {
			this.topText.text(newText);
		},

		/**
		 * Set the text at the bottom of the scale
		 */
		setBottomText: function( newText ) {
			this.bottomText.text(newText);
		},

		/**
		 * Set the colour of the liquid in the thermometer. This must
		 * be of the form #ffffff. The shortened form and the rgb() form
		 * are not supported.
		 */
		setLiquidColour: function( newColour ) {

			this.options.liquidColour = newColour;
			this._updateLiquidColour();
		},

		/**
		 * Returns the liquid colour. If this is controlled by a colour
		 * function, then it returns the colour for the current value.
		 */
		getLiquidColour: function() {
			if( $.isFunction( this.options.liquidColour ) ) {
				return this.options.liquidColour( this.currentValue );
			} else {
				return this.options.liquidColour;
			}
		},

		_updateLiquidColour: function() {
			var liquidColour = this.getLiquidColour();

			var variables = [];
			variables["colour"] = liquidColour;
			variables["darkColour"] = this._blendColors( liquidColour, "#000000", 0.1 );
			variables["veryDarkColour"] = this._blendColors( liquidColour, '#000000', 0.2 );
		
			this._formatDataAttribute( this.neckLiquid, "style", variables );
			this._formatDataAttribute( this.liquidTop, "style", variables );
			this._formatDataAttribute( this.bowlLiquid, "style", variables );
			this._formatDataAttribute( this.bowlGlass, "style", variables );
			this._formatDataAttribute( this.neckGlass, "style", variables );
		},

		_setupSVGLinks: function() {
			// This is all a bit magic, but these numbers come
			// from the SVG itself and so this will only work with
			// a specific SVG file.
			this.liquidBottomY = 346;
			this.liquidTopY = 25;
			this.neckBottomY = 573;
			this.neckTopY = 250;
			this.neckMinSize = 30;
			this.svgHeight = 1052;
			this.leftOffset = 300;
			this.topOffset = 150;
			this.liquidTop = $('#LiquidTop path');
			this.neckLiquid = $('#NeckLiquid path');
			this.bowlLiquid = $('#BowlLiquid path');
			this.topText = $('#topText');
			this.bottomText = $('#bottomText');
			this.bowlGlass = $('#BowlGlass');
			this.neckGlass = $('#NeckGlass');
		},

		_create: function() {
			var self = this;
			var div = $('<div/>');
			this.div = div;
			this.element.append( div );

			div.load( this.options.pathToSVG, null, function() {
				self._setupSVGLinks();

				// Scale the SVG to the options provided.
				var svg = $(this).find("svg");
				var width = svg.attr("width");
				var height = svg.attr("height");
				svg[0].setAttribute( "preserveAspectRatio", "xMinYMin meet" );
				svg[0].setAttribute( "viewBox", self.leftOffset+" "+self.topOffset+" "+width+" "+height );

				svg.attr("width",  self.options.width );
				svg.attr("height", self.options.height );

				// Setup the SVG to the given options
				self.currentValue = self.options.startValue;
				self.setValue( self.options.startValue );
				self.setTopText( self.options.topText );
				self.setBottomText( self.options.bottomText );
				self.setLiquidColour( self.options.liquidColour );
			} );
		},

		_update: function() {
			var self = this;
			var valueProperty = {val: this.currentValue};
			$(valueProperty).animate( {val: this.valueToAttain}, {
				duration: this.options.animationSpeed,
				step: function() {
					self._updateViewToValue( this.val );
					self.currentValue = this.val;
				}
			} );
		},

		_updateViewToValue: function( value ) {

			// Allow the liquid colour to be controlled by a function based on value
			if( $.isFunction( this.options.liquidColour ) ) {
				this._updateLiquidColour();
			}


			var variables = [];
			variables["liquidY"] = this.liquidBottomY - value * (this.liquidBottomY - this.liquidTopY) / (this.options.maxValue - this.options.minValue);
			variables["neckPosition"] = value * (this.neckBottomY - this.neckTopY) / (this.options.maxValue - this.options.minValue) + this.neckMinSize;
			variables["boxPosition"] = this.neckBottomY - variables["neckPosition"];

			// Move the oval representing the top of the liquid
			this._formatDataAttribute( this.liquidTop, "transform", variables );

			// Stretch the box representing the liquid in the neck
			this._formatDataAttribute( this.neckLiquid, "d", variables );
			// y = value * (this.neckBottomY - this.neckTopY) / (this.options.maxValue - this.options.minValue) + this.neckMinSize;
			// yPos = this.neckBottomY - y;
			// this.neckLiquid[0].setAttribute("d", "m 393.28125,"+yPos+" c -4.19808,0 -7.5625,3.36442 -7.5625,7.5625 l 0,"+y+" c 10.74167,-4.84591 22.63806,-7.53125 35.1875,-7.53125 11.83467,0 23.12028,2.41262 33.375,6.75 l 0,-"+y+" c 0,-4.19808 -3.36442,-7.5625 -7.5625,-7.5625 l -53.4375,0 z" );

			// Call the valueChanged callback.
			if( this.options.valueChanged ) {
				this.options.valueChanged( value );
			}
		},

		_formatDataAttribute: function( object, attribute, variables ) {
			var formatString = $(object).attr("data-"+attribute);
			for( v in variables ) {
				formatString = formatString.replace( new RegExp("%%"+v+"%%", "g"), variables[v] );
			}
			$(object).attr(attribute,formatString);
		},

		_replaceFill: function( oldStyle, newFill ) {
			return this._replaceOption("fill", oldStyle, newFill );
		},

		_replaceStroke: function( oldStyle, newStroke ) {
			return this._replaceOption("stroke", oldStyle, newStroke );
		},

		_replaceOption: function( optionName, oldStyle, newOption ) {
			return oldStyle.replace(
				new RegExp(optionName+":#[a-z0-9]{6}", "i"), 
				optionName+":"+newOption );
		},

		// http://stackoverflow.com/questions/5560248/programmatically-lighten-or-darken-a-hex-color-or-rgb-and-blend-colors
		_blendColors: function(c0, c1, p) {
			var f=parseInt(c0.slice(1),16),t=parseInt(c1.slice(1),16),R1=f>>16,G1=f>>8&0x00FF,B1=f&0x0000FF,R2=t>>16,G2=t>>8&0x00FF,B2=t&0x0000FF;
			return "#"+(0x1000000+(Math.round((R2-R1)*p)+R1)*0x10000+(Math.round((G2-G1)*p)+G1)*0x100+(Math.round((B2-B1)*p)+B1)).toString(16).slice(1);
		},


		// Default options
		options: {
			height: 700,
			minValue: 0,
			maxValue: 8,
			startValue: 0,
			topText: 8,
			bottomText: 0,
			liquidColour: "#ff0000",
			animationSpeed: 1000,
			pathToSVG: "svg/thermo-bottom.svg",
			valueChanged: undefined
		}
	}

	$.widget( "dd.thermometer", Thermometer );

})(jQuery);
