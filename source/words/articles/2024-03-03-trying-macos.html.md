---
title: Trying macOS
date: 2024-03-03 19:17 UTC
author: Ólafur Guðmundsson
tags: apple, macos, windows
published: true
---

I had never used macOS before in my life apart from the occasional messing about if I came across them in a computer shop. But for work reasons I felt I needed to get to know it better which triggered me trying out a Macbook Pro for the first time and go through the pain of shifting from Windows.

I have mainly used Windows during my professional career but also run Linux as my daily driver for a few stints, and very frequently on the side on personal machines. So I was familiar with the "unix" way somewhat and also just been generally curiuos about macOS for a while. See what the fuss is about.

The machine I got has the following specs:

![The Macbook 2018 I used for the first test](attachments/macos.png)

I made notes on the side as I tested it over the first few weeks and here are some of the pros and cons I noticed compared to Windows and Linux:

**Pros:**

* I really like the ```Cmd``` and ```Option``` key combinations to move or delete single words or full lines at a time.

* Props for the Easy Move+Risize app (_since replaced with [Swift Shift](https://github.com/pablopunk/SwiftShift) as the former has been deprecated_). I've gotten hooked on the Linux (at least Gnome) built-in hold alt + left or right-click the mouse to move or resize windows. I use [AltSnap](https://github.com/RamonUnch/AltSnap) on Windows now for this.

* I *love* the touchpad and keyboard. Heard this repeatedly throughout the years from Mac enthusiast but, yeah, I agree. Get to know the gestures as well and watch a few YouTube videos about how to configure the defaults to your liking. For me I set three-finger drag at least and enabled tap to click. The four-finger drag upwards to show all windows and right-left to move between virtual workspaces is also super nice. They've borrowed some of this from Linux and later on Microsoft with Windows 11.

* Smooth UI transitions vs. Windows although Linux is in my view more smooth in many ways than Window as well. Moving windows around, switching workspaces. Plugging in/out of a dock with an external monitor. Windows know where they should be and it's consistent. Windows struggles with this and is all janky somehow, although much better with 11.

* Consistency in both UI and UX. For example then ```Cmd + ,``` is *always* the shortcut to the settings menu of an app. Also ```Cmd + q``` always kills an app.

* [Homebrew](https://brew.sh) and the App Store. Super nice. I am fond of the Linux package manager mentality for ease of discovery, installation and updates. This gets you closer to that for macOS. Windows is getting there with WinGet and Microsoft Store but ways to go still.

* Speakers and hardware in general miles ahead of what I've tried for Windows/Linux. Used mostly Lenovo and Dell.

* Consistent light/dark switch with OS features in apps. Windows is getting there. And the OS can switch depending on time of day. Don't think Windows can do that but Linux can (of course).

**Cons:**

* Screenshots are confusing but kind of gotten the hang of it using [Shottr](https://shottr.cc/). May be a get-used-to-it thing. I've used [Greenshot](https://getgreenshot.org/) on Windows.

* Caps lock delay. Oh shit this is annoying. Apparently a feature.

* Peripherals seem to sometimes have weird compatibility issues compared to Windows and Linux. For example connecting to a couple Lenovo docks I've used for a long time without a hitch for both Windows and Linux suddenly needed some TLC to get to work with macOS. I have wide-screen monitors and a keyboard/mouse combo connected on both of these, one at home and one at work. Had to figure out how to make the OS realize which layout my keyboard was. Lots of jumping through hoops until it suddenly worked. Not sure why.

* Widgets (from the top-right) not that useful. E.g. getting a quick view and flip through months of the calendar not possible in macOS, I have to click through to open the Calendar app. This is trivial both on Windows and Linux.

* It's a meme by now but I am firm on that macOS updates take way longer than Windows updates. They are fewer and further between though.

To summarize, I very much like the consistency, simplicity and general *feel* of the machine. Once you're up and running it's just so smooth. No nitpicks that you're so used to with Windows (funnily enough, often related to location, size or displaying of ... windows). Since this initial experiment I've gotten a newer more powerful machine; Macbook Pro 2021 M1. Huge difference in performance, like it even more. I will still continue to take turns, I need to be familiar with both macOS and Windows functionality and setup, but I do tend to like switching it up regularly so no complaints.

A few random pointers for newcomers to macOS, in no particular order:

1. Go to YouTube and pick 2-3 videos at least about getting to know macOS and how to configure some basic things. It is different, try to embrace the difference before changing it too much.
2. Install [Homebrew](https://brew.sh).
1. Consider installing some of these that I've found useful:
    * [Raycast](https://www.raycast.com/) - monster upgrade from Spotlight.
        * ```brew install --cask raycast```
    * [Rectangle](https://rectangleapp.com/) - for window management/placement. However with Raycast you may not need this since Raycast can move windows around as well.
        * ```brew install --cask rectangle```
    * [Swift Shift](https://github.com/pablopunk/SwiftShift) - as described above
        * ```brew install --cask swift-shift```
    * [Shottr](https://shottr.cc/) - for screenshots, if you're overwhelmed by [the macOS shortcuts features](https://support.apple.com/en-is/guide/mac-help/mh26782/mac).
        * ```brew install --cask shottr```
    * [Flux]() - for managing night light on an external monitor, seems macOS can't handle that for all external monitors.
1. Be warned that the first few days will be *very* annoying, just while you go through the pain of your regular keyboard habits don't work as well and many things work differently. Account for *at least* a month to get used to a new way of working, preferably two. Only after that time you can start to make real complaints.

Thanks for reading.
