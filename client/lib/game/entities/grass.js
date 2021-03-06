ig.module('game.entities.grass')

.requires('impact.entity')

.defines(function() {

	EntityGrass = ig.Entity.extend({

		size: {
			x: 16,
			y: 16
		},

		// Should be above player entities zPriority.
		zPriority: 4,

		// Used simply to tell how long entity has existed.
		timer: undefined,

		// Load image resource.
		animSheet: new ig.AnimationSheet('media/rs.grass.png', 16, 16),

		// Used to keep entity alive briefly before killing.
		killTimer: null,

		// Is set to true when markForDeath() is called.
		markedForDeath: false,

		// Start count-down until this entity will be killed.
		markForDeath: function() {

			// Set the timer.
			this.killTimer.set(3);

			// Allow removal of entity.
			this.markedForDeath = true;
		},

		// Save this entity from being killed.
		revive: function() {
			this.markedForDeath = false;
		},

		init: function(x, y, settings) {
			this.parent(x, y, settings);

			this.timer = new ig.Timer();

			// Create timer to count-down to entity's death.
			this.killTimer = new ig.Timer();

			// Set zIndex.
			this.zIndex = this.zPriority + this.pos.y,

			// The number 6 does not exist in the sprite sheet and is used as a 'blank'.
			this.addAnim('rustle', (2 / 60), [6, 6, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4], true);
			this.addAnim('static', (4 / 60), [6, 4], true);

			this.currentAnim = this.anims['static'];
		},

		play: function() {

			// Rewind to first frame.
			this.anims.rustle.rewind();

			// Set animation.
			this.currentAnim = this.anims.rustle;
		},

		// Override all update function.
		update: function() {

			// Update animations.
			if (this.currentAnim != null) this.currentAnim.update();

			// Check if entity is no longer needed.
			if (this.markedForDeath && this.killTimer.delta() >= 0) {
				// Free up resources.
				this.kill();
			}
		}

	});
});