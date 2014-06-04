[
// Either load the file valid_nanp.inc during server or site startup,
// in server or site library, or include it.  Choose one method.
// I recommend site startup.
// include('valid_nanp.inc'); // optional loading method
]<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>valid_nanp by Steve Piercy</title>
</head>
<body>
    <h1>valid_nanp by Steve Piercy</h1>
<form action="[response_filepath]" method="post">
<p>
<label>Phone</label><input name="phone" type="text" placeholder="enter phone number" value="[action_param('phone')]" />
</p>
<p>
<label>Format</label><input name="format" type="text" placeholder="enter format string" value="[action_param('format')]" /><br />
(use # as a replacement for numbers, and any other character for formatting, e.g., "(###) ###-#### x####")
</p>
<input name="submit" id="submit" type="submit" value="Submit" class="button" />
</form>

[
if(action_param('phone') != '');
    '<h2>';
    if(action_param('format') != '');
        valid_nanp(
        -number=action_param('phone'),
        -format=action_param('format'));
    else;
        valid_nanp(
        -number=action_param('phone'));
    /if;
    '</h2>';
else(action_param('submit') == 'Submit');
    '<p style="color:red; font-weight: bold;">Enter a phone number</p>';
/if;
]

<h1>Examples</h1>
[local('phone1') = '631-960-7187']

<h2><pre>['[']valid_nanp('631-960-7187')[']']</pre></h2>
<p>[valid_nanp(#phone1)]</p>

[local('phone2') = '401-285-0696']
<h2><pre>['[']valid_nanp('401-285-0696', -format='(###) ###-#### x######')[']']</pre></h2>
<p>[valid_nanp(#phone2, -format='(###) ###-#### x######')]</p>

[local('phone3') = 'oogahboogah401oopsie-285-0696ext12345']
<h2><pre>['[']valid_nanp('oogahboogah401oopsie-285-0696ext12345',<br />-format='(###) ###-#### x######')[']']</pre></h2>
<p>[valid_nanp(#phone3, -format='(###) ###-#### x######')]</p>

</body>
</html>
