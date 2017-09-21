(function($) {

    $(document).ready(function() {

        Slider('.slider', {
                sliderHeight: Slider.prototype.HEIGHT_MAX,
                loop: true,
                itemsPerSlide: 1
            }).attachPlugins([
                SliderSideAnimation({
                    margin: 20
                }),
                SliderSideShortestAnimation({
                    margin: 20
                }),
                SliderFadeAnimation({
                    animationName: 'side-shortest'
                }),
                SliderControlsPlugin({
                    animationName: 'side-shortest'
                }),
                SliderNavigationPlugin({
                    animationName: 'side'
                }),
                SliderDragPlugin({
                    margin: 20
                })
                // SliderAutoscrollPlugin({
                //     animationName: 'fade',
                //     direction: 'random',
                //     interval: 6000
                // })
            ]);

            Slider('.slider2', {
                sliderHeight: Slider.prototype.HEIGHT_MAX,
                loop: true,
                itemsPerSlide: 2
            }).attachPlugins([
                SliderSideAnimation({
                    margin: 20
                }),
                SliderSideShortestAnimation({
                    margin: 20
                }),
                SliderFadeAnimation(),
                SliderControlsPlugin({
                    animationName: 'side-shortest'
                }),
                SliderNavigationPlugin({
                    animationName: 'side'
                }),
                SliderDragPlugin({
                    margin: 20
                }),
                SliderAutoscrollPlugin({
                    animationName: 'fade',
                    direction: 'random',
                    // interval: 6000
                })
            ]);
    });

})(jQuery);