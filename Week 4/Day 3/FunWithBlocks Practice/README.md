## Fun with blocks ##

1. Clone the fun with blocks repo
2. Open the project and have a look at the initial setup of the view controller. As you can see, there is already an image view setup added to the view controller for you.
3. The `loadWallpaper` method is called each time we tap on the screen and also when `viewDidLoad` finishes.
4. Implement `loadWallpaper` so that increments the `lastWallpaperIndex`, gets the image name at the given `lastWallpaperIndex` of the `wallpapers` array, creates a UIImage with the image name and sets the image view's image (hints: be careful with the index exceeding the bounds of the array).
5. Refactor the code from the previous section so that we call a fetch image method passing an integer index and a block that receives an image as a parameter.
6. Because we have really large images, we need to scale them. Implement another method that receives an UIImage, a float width and a block that receives an image as a parameter. This method should:
    - Create a new CGSize with the given width parameter and a new height, respecting the aspect ratio
    - Draw the image using core graphics with the new size
    - Finish with the completion block and the new image
    - Finally, call this method from the previous one
7. Note that now we have two methods that have a same block type. Use typedefs to create a same type for all.
8. Within load wallpaper, animate the image view's `alpha` before and after fetching the image. Use two UIView animations with 0.5 seconds duration.
9. Right before the second alpha animation, call a `bounceImage` void method that you will need to implement. This method will perform a scale animation on the image view, linking three UIView animations that will scale the image view 10% bigger, 10% smaller and the proper size respectively, with a 0.25 seconds duration.
10. Refactor `bounceImage` so that we only need to write 1 UIView animation. We will need a separate method with a block parameter for this (bonus points if you typedef the block parameter)
