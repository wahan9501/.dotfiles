# Web Cheatsheet
> Last Modified Time: {docsify-updated}

# Document Website Generator
|            | pros                                                         | cons                                                         |
| ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Slate      | Built in search.                                             | - Need Linux, Perl Env to init. Not convinent on Windows.<br />- Seems maintenance is not active. |
| Docsify✔   | - Built in powerful search.<br />- Simple architecture.<br />- Active maintenance. | No blocking defects.                                         |
| Docusaurus | - Richer documentation functions.                            | Search function rely on external search service.             |
| Vuepress   | - More lovable UI.                                           | Search function rely on external search service.             |

# ES6 import
- import Foo from 'foo'; // default import: import default export
- import {Foo} from 'foo'; // named import: import named export
- import * as Foo from 'foo'; // namespace import: import wholemodule
example
```js
import SomeName from 'export'; // 'SomeName' is now the {a: 1} instance.
import {b} from 'export'; // 'b' is now the {b: 2} instance.
import * as ns from 'export'; /* 'ns' now has properties 'default', 'b' & 'c',
  representing {a: 1}, {b: 2} & {c: 3} respectively */
```

# Terminology
- Modal vs Modeless
  https://en.wikipedia.org/wiki/Modal_window
  Modal is sub window/dialog that block main window before user react.
  Modeless window is simimlar window but don't block user.



