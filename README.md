# Unity IOS Can Open URL

### Install
Copy/paste into your unity ```Assets``` folder

### What I can do? 

You can check **is some application installed** on iOS. Keep in mind that you need to know checking app URL sheme. 
More information about this [here](https://developer.apple.com/documentation/uikit/uiapplication/1622952-canopenurl?language=objc)

### Example

``` c#

private void OpenInstagramApp()
{
    var link = "https://www.instagram.com/nrjwolf.games/";
    // check to open in app IOS ONLY
    var iosAppLink = "instagram://user?username=nrjwolf.games";
    if (IOSCanOpenURL.CheckUrl(iosAppLink))
    {
        link = iosAppLink;
    }
    Application.OpenURL(link);
}

```

So in this example I checking is *instagram* installed. If yes, will open application link, if no, will open it in browser. 

>I'm on [reddit](https://www.reddit.com/r/Nrjwolf/)  
>[Discord server](https://discord.gg/jwPVsat)
