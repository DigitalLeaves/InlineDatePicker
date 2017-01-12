# InlineDatePicker

Unlike most date pickers found in web applications, iOS UIDatePicker is one of the most bulkier controls in the standard UIKit library, and among the most difficult ones to integrate in a screen when multiple controls are required, maybe alongside several text fields in charge of collecting information. That's why Apple wisely decided to make them less obnoxious by hiding them until you need them by means of a clever animation.

![http://digitalleaves.com/blog/wp-content/uploads/2017/01/DynamicUIDatePicker.gif](http://digitalleaves.com/blog/wp-content/uploads/2017/01/DynamicUIDatePicker.gif)

Usually, Apple iOS applications collecting data or presenting the user a set of settings, where information needs to be provided by the user, employ a smart animation in which any time or date field is shown as a textfield or label in a row inside a table view (with the rest of the UITextFields in other rows) and then, when you click on that row, an animation will reveal a hidden UIDatePicker below. The illusion works well and the user is intuitively led to choose a date or time associated to that field.

In [this post](http://digitalleaves.com/blog/2017/01/dynamic-uidatepickers-in-a-table-view/), we are going to learn how to use this technique to show and dismiss a UIDatePicker in a row inside a table when needed.

# LICENSE

This code is under the MIT License.

Copyright 2017 Ignacio Nieto Carvajal (https://digitalleaves.com).

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
