Thank you all for a lovely few days in DC. All the Mapboxers I met and worked with were welcoming, candid, delightful, and generally inspiring. I was particularly impressed by the positive energy and powerful trust: I think this combination sustains a unique atmosphere of curiosity, enthusiasm, and collaborative support, which in turn powers Mapbox's impressive achievements. That was a long sentence, so I will try to illustrate it visually:

![](Gifs/a1.gif?raw=true)


For those I didn't meet: Hello! I'm David Clark, an English-teacher-turned-frontend developer living in Tucson, Arizona. (Yes, I am the second Clark from Tucson interested in working at Mapbox.)

## Adding keyboard interactions to Studio

I sprinted with the splendid Studio team. After a quick introduction to the application's sizable, cutting-edge codebase (three cheers for Flow and Immutable!), I dove into a very particular problem: add more keybindings to Studio's layers panel.

One of Studio's most important audiences is professional designers and cartographers, who might end up using the application for many hours a day. Power users. And many of those power users appreciate and expect keybindings. Many, in fact, like our poor friend below, may be frustrated and depressed by their absence.

![frustrated-computer-baboon](https://github.com/davidtheclark/gifs/blob/master/frustrated-computer-baboob.gif)

Keyboard interactions also lend themselves to Selenium integration tests better than than their mousy counterparts. So by increasing their numbers we also improve the testability of the UI.

Studio already supports a number of keyboard interactions; but there's plenty of room for more. In my short time at the Garage, I worked on adding a couple of straightforward shortcuts and a couple more complex behaviors.

### The simple ones

Often any action that can be accomplished with the click of a button can be easily mapped to a keyboard shortcut. This had already been done in Studio with hiding, grouping, and adding layers (`v`, `g`, and `n`, respectively); I added shortcuts corresponding to two remaining layer-panel buttons, duplicate (`d`) and delete (`cmd+backspace`).

Along with these, there are at least one or two more straightforward shortcuts we could add to Studio's layer panel. And although the existing Help popover is excellent, there are still more ways we could improve the discoverability and documentation of Studio's keybindings.

### The complex ones

Thanks to some smart patterns in Studio and its supporting modules, the above additions took about 20 minutes, really. (Map a keystroke to an existing function, the one triggered by the button, then pat yourself on the back.) The bulk of my time was consumed by the tangled intricacies of two more complex behaviors: the multiselection and moving of layers.

This kind of thing happens pretty often in UI development: A new interaction idea appears simple — on its surface, when it's written in a ticket. And, indeed, the most obvious use-case proves easy enough to handle. But when you dig in and test things out, you uncover a horde of state-driven variations and edge-cases. Nail one case and two more arise, like accursed imps.

Take, for example, the moving of layers. First you enable keystrokes that move a single selected layer up and down. Then you ensure the movement stops at the top and bottom of the list. Then you make the same patterns work when multiple continuous layers are selected. Then, to your horror, you realize you'll have to deal with layer *groups* (kind of like folders), which can be either expanded or collapsed, and which your selection must enter, exit, and skip in intuitive ways. And what if your selection contains layers from both inside and outside a group, or layers from different groups? And what if your selection is *discontinuous*, containing, say, layers 2 and 5 but not 3 and 4? And what if one of those discontinuous layers is at the top or bottom of the list, or the top or bottom of a group? And so on.

![alarum](https://github.com/davidtheclark/gifs/blob/master/alarum.gif)

There are enough variations arising from slightly different conditions that it can become very difficult to keep them all in mind at once. You end up breaking one case by fixing another. So what can you do?

First: drop the mess for a time and come back to it! Each morning I succeeded in untangling a logic-snarl that had stumped me at the end of the previous night. (Probably it was the rest ... but it also may have been the positive influence of Peregrine Espresso's almond croissants.)

Second: write tests! Multiselecting and moving layers turned out to be great situations for unit-test-driven development — which is not as widely practiced in client-side JS as it should be. I extracted and modularized the heavy logic for those tricky interactions; wrote lots and lots of unit tests to capture all the variations I could think of; then tweaked the code until those tests passed.

Third: try rewriting complex code! As you could guess from the paragraph above the distressed Bugs Bunny, there could be lots of branching conditionals involved when, for example, deciding what exactly `alt+up-arrow` should do. A first draft that seems to work, written in the throes of problem-solving furor, may end up too labyrinthine for you or others to read or modify. So it can be very helpful to comment out the draft, step back, stretch your legs, pray for clarity, then try to rewrite that bit of code to do the same thing with fewer twists, clearer variable and function names, and better comments. I know that when I do this I always come out with a better, more extensible, more legible solution.

After all that, here's a quick glance at how the interactions ended up working.

![multiselect-demo](https://github.com/davidtheclark/gifs/blob/master/multiselect-demo.gif)
![move-demo](https://github.com/davidtheclark/gifs/blob/master/move-demo.gif)

## Until next time ...

Cheers to you if you made it this far, and thanks for reading!

Mapbox is an extraordinary and exciting place, and I'm glad I had the opportunity to peek in and contribute.
