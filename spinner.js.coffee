# A simple CoffeeScript class with static methods for turning any
# DOM element into a spinner.
#
# Requires jQuery.
#
# @example Using your logo image as a spinner
#   logo = $('img.logo')
#   Spinner.start(logo)
#   # ...time passes...
#   Spinner.stop(logo)
#
# @version 1.0.0
# @copyright 2014 Scott W. Bradley - Licensed under the MIT License
#
class @Spinner

  # Start the specified element infinitely.
  #
  # @param elem [jQUery] The jQuery element to use as a Spinner
  #
  @start: (elem) ->
    Spinner._rotateOnce elem, -> Spinner.start elem

  # Stop the specified element from spinning and reset it to its
  # 0-degree rotation.
  #
  # @param elem [jQuery] The jQuery element to stop spinning
  #
  @stop: (elem) ->
    elem.stop()
    Spinner._setRotation elem, 0


  #-----------------------------------------------------------
  # Internal Methods
  #-----------------------------------------------------------

  # @nodoc
  @_rotateOnce: (elem, onComplete) ->
    elem.css 'rotationIndex', 0
    elem.animate(
      {rotationIndex: 360},
      {
        step: (now,fx) -> Spinner._setRotation elem, now
        duration: 'slow'
        easing: 'linear'
        complete: onComplete
      }
    )

  # @nodoc
  @_setRotation: (elem, degrees) ->
    rotation = "rotate(#{degrees}deg)"
    elem.css
      '-webkit-transform': rotation
      '-moz-transform': rotation
      '-ms-transform': rotation
      '-o-transform': rotation
      'transform': rotation
