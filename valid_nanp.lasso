[
define_tag('valid_nanp', -description='Determines whether a string contains a valid phone number according to the North American Numbering Plan <http://en.wikipedia.org/wiki/North_American_Numbering_Plan>.  Validation ignores all non-numeric characters.  Additionally the number must have at least 10 digits and does not begin with "+1".  Phone numbers with extensions are permitted, where any digit beyond the first 10 digits forms the extension.  Optionally formats the output, substituting "#" for digits, and inserting any other arbitrary character.',
    -required='number', -type='string', -copy,  // the phone number to test (and optionally format)
    -optional='format', -type='string', // the format string
    -priority='replace');

    local('v') = false; // var for storing whether a number is valid
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
        local('f') = string;    // formatted output
        local('d') = 1;         // digit index position
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
