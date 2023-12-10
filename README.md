# Saving and loading with Godot

<p align="center">
  <p align="center">
  <a href="https://www.youtube.com/watch?v=43BZsLZheA4"><img src="https://i3.ytimg.com/vi/43BZsLZheA4/hqdefault.jpg" alt="Saving and Loading with Godot, Video on YouTube Cover Image"></a> 
  </p>
</p>

Hello, Godotneers! Thank you very much for watching this video. This repository contains the little game we used in the video. You can use it to follow along with the video or to experiment with the code. 

## Using this repository
There is a `start` branch that contains the code as it was at the beginning of the video. You can use this branch to follow along with the video if you'd like.

The `main` branch contains the code as it was at the end of the video. It also includes some additional features:

 - It adds some things mentioned in the article below, e.g. the `PathFixer` and the handling of deleted or renamed items.
 - It adds some additional comments to the code, so it's easier to follow even if you didn't watch the video.
 - It adds saving and loading for the towers which are part of the later levels. These were not shown in the video. Check the (`tower.gd`)[tower/tower.gd] and (`saved_tower_data.gd`)[tower/saved_tower_data.gd] scripts for details.
 - It adds saving and loading the current level, so if you save in level 3, you will continue in level 3 when you load the game. This also was not shown in the video. Check the updated  (`saver_loader.gd`)[saver_loader/saver_loader.gd] script for details.

If you don't know how to use git, you can also download the code as a zip file using these links:

- [Download the code as a zip file (main branch, at the end of the video)](https://github.com/godotneers/saving-loading-video/archive/refs/heads/main.zip)
- [Download the code as a zip file (start branch, at the beginning of the video)](https://github.com/godotneers/saving-loading-video/archive/refs/heads/start.zip)

## Additional material

Be sure to also check the [article on saved game compatibility](https://raw.githubusercontent.com/godotneers/saving-loading-video/main/godotneers-ensuring-saved-game-compatibility.pdf), it contains a lot of useful strategies to ensure your saved games are compatible across different versions of your game.


## Support me

If this video and the example code were helpful to you, please consider supporting me on [Ko-fi](https://ko-fi.com/derkork). Thank you very much!


## License

The code and all assets except the article in this repository are licensed under the MIT license. See the LICENSE file for more information. The article is licensed under CC BY-SA 4.0. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/.
