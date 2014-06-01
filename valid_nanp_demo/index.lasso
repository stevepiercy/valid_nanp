[
define_tag('valid_nanp', -description='Determines whether a string contains a valid phone number according to the North American Numbering Plan <http://en.wikipedia.org/wiki/North_American_Numbering_Plan>.  Validation ignores all non-numeric characters.  Additionally the number must have at least 10 digits and does not begin with "+1".  Phone numbers with extensions are permitted, where any digit beyond the first 10 digits forms the extension.  Optionally formats the output, substituting "#" for digits, and inserting any other arbitrary character.',
    -required='number', -type='string', -copy,	// the phone number to test (and optionally format)
    -optional='format', -type='string',	// the format string
    -priority='replace');

    local('v') = false;	// var for storing whether a number is valid
    #number = string_replaceregexp(#number,-find='\\D',-replace='');

    // validation requirements according to NANP, with optional extension
    if(integer(#number->substring(1,1)) >= 2
        && integer(#number->substring(2,1)) <= 8
        && integer(#number->substring(4,1)) >= 2
        && #number->size >= 10);
        #v = true;
    /if;

    if(local_defined('format') && #v);
        // format the number only if requested and is a valid phone number
        local('f') = string;	// formatted output
        local('d') = 1;			// digit index position
        iterate(#format->split(''),local('i'));
            if(#number->size > 10 || #d <= 10);
                if(#i=='#');
                    #f+=#number->substring(#d,1);
                    #d+=1;
                else;
                    #f+=#i;
                /if;
            /if;
        /iterate;
        return(#f);
    else;
        // else just return whether the number is valid
        return(#v);
    /if;
/define_tag;
]
<html>
<head>
    <meta charset="utf-8" />
    <title>tz_convert by Steve Piercy</title>
    <link rel="stylesheet" type="text/css" media="screen" href="jquery.datetimeentry.css" />
</head>
<body>

<h1>valid_nanp Demo</h1>
<form action="[response_filepath]" method="post">
<p>
Phone: <input name="phone" type="text" placeholder="enter phone number" value="[action_param('phone')]" />
</p>
<p>
Format: <input name="format" type="text" placeholder="enter format string" value="[action_param('format')]" /><br />
(use # as a replacement for numbers, and any other character for formatting, e.g., "(###) ###-#### x####")
</p>
<input name="submit" id="submit" type="submit" value="submit" />
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
<h2><pre>['[']valid_nanp('oogahboogah401oopsie-285-0696ext12345', -format='(###) ###-#### x######')[']']</pre></h2>
<p>[valid_nanp(#phone3, -format='(###) ###-#### x######')]</p>

</body>
</html>
