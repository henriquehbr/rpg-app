# rpg-app
A table top rpg manager

## Dependencies
* [gulp](https://gulpjs.com/) - Streaming build system
  * [gulp-pug](https://github.com/gulp-community/gulp-pug) - Gulp plugin for compiling Pug templates
  * [gulp-stylus](https://github.com/stevelacy/gulp-stylus) - Gulp plugin for compiling Stylus stylesheets
  * [gulp-coffee](https://github.com/gulp-community/gulp-coffee) - Gulp plugin for compiling CoffeeScript code into vanilla JavaScript
  * [gulp-terser](https://github.com/terinjokes/gulp-uglify) - Gulp plugin for minifying JavaScript files (ES6+ compatible)
* [terser](https://github.com/terser-js/terser) - JavaScript parser, mangler, optimizer and beautifier toolkit for ES6+
* [pug](https://pugjs.org/api/getting-started.html) - robust, elegant, feature rich template engine for Node.js
* [stylus](http://stylus-lang.com/) - Expressive, robust, feature-rich CSS language built for Node.js
* [coffeescript](https://coffeescript.org/) - a little language that compiles into JavaScript

## Build

In order to get everything up and running, just run:

```
gulp
```

otherwise, if you want to build manually...

#### pug
````
pug src/*.pug -o dist/
````
##### Compiles all Pug templates on `src` to the `dist` directory

#### stylus
```
stylus src/css/*.styl --out dist/css/
```
##### Compiles all Stylus stylesheets on `src/css` to the `dist/css` directory

#### coffeescript
```
coffee --no-header -o dist/js -c src/js/*.coffee
```
##### Compiles all CoffeeScript files on `src/js` to the `dist/js` directory