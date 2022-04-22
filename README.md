# PocOne

Executes `word-count.js` using assigns from page view returning a declarative shadowroot server side rendered:

![image](https://user-images.githubusercontent.com/22575742/164766165-1e5e8340-ecfe-40c5-acc6-11cb5919369e.png)

which transitions seamlessly into normal execution:

![image](https://user-images.githubusercontent.com/22575742/164766294-3851c67f-0e5a-4829-a1b7-8c0b54d9af5a.png)


## Outstanding Unknowns

- Preparing the render (the simple wrapper I have won't work for more complex frameworks/elements)
- Haven't tested with typescript
- Browser support for`<template shadowroot=open>`

## Outstanding knowns

- Building the engine to:
  - get the file without IO
  - inject the call for webcomponents in templates
