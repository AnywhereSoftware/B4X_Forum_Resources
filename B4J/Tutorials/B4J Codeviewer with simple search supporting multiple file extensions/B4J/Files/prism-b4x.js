Prism.languages.b4x = {
	'excluded': [
		{
			pattern: /^\s*#if[\s\S]+?(?=#end\s+if)/im
		},
		{	
			pattern: /^\s*#end\s+if/im
		}
	]
	,
	
	'comment': {
		pattern: /'[^\n]*/i,
	},
	'string': [
		{
			pattern: /"(?:""|[!#$%&'()*,\/:;<=>?^_ +\-.A-Z\d])*"/i,
			greedy: true
		},
		{
			pattern: /\$"[\s\S]*?"\$/i,
			greedy: true,
			inside: {
				'regular': {
				pattern: /(\$\{)[^}\n]+?(?=\})/i,
					lookbehind: true
				}
			}
		}
	],
	
	'poundline': {
		pattern: /^\s*#.+/im,
		inside: {
			'region': /#(end\s+)?region.*/i,
			'annotation':/#\w+:/,
			'string':/\b\w+\b/
		}
	},
	'sub_line': {
		pattern: /^\s*(?:private|public)?\s*sub\s[^\(\n]*/im,
		inside: {
			'bold': {
				pattern: /(sub)\s+\b\w+\b/i,
				lookbehind: true
			}
		}
	},
	'as_keyword': {
		pattern: /\bas\s+\w+/i,
		inside: {
			'type': {
				pattern: /(as)\s+\w+/i,
				lookbehind: true
			}
		}
	},
	'number': /(?:\b\d+\.?\d*|\B\.\d+)(?:E[+-]?\d+)?(dip|%x|%y)?/i,
	'keyword': /\b(?:IF|TRY|CATCH|DIM|WHILE|UNTIL|STEP|THEN|ELSE|END|FOR|NEXT|DO|EACH|IN|TYPE|LOOP|RETURN|ARRAY|TO|CASE|WAIT|PRIVATE|PUBLIC|CONST|END IF|END SUB|END TRY|END SELECT|DO WHILE|DO UNTIL|FOR EACH|AND|OR|MOD|TAN|CALLSUBDELAYED3|RNDSEED|CALLSUBDELAYED2|RND|CALLSUB|CHR|SETSYSTEMPROPERTY|ACOS|COSD|CALLSUB3|ATAND|CALLSUB2|EXIT|SUB|LOG|ATAN2|CALLSUBDELAYED|SIND|GETTYPE|SENDER|NOT|MIN|LOGERROR|ME|SIN|CEIL|CREATEMAP|ATAN|LASTEXCEPTION|TAND|ROUND2|NUMBERFORMAT2|MAX|ASIN|CHARSTOSTRING|ACOSD|ATAN2D|DIPTOCURRENT|IS|CONTINUE|SMARTSTRINGFORMATTER|STOPMESSAGELOOP|ASC|LOGDEBUG|ABS|ISNUMBER|LOGARITHM|EXITAPPLICATION|ROUND|STARTMESSAGELOOP|SUBEXISTS|BYTESTOSTRING|FLOOR|GETENVIRONMENTVARIABLE|GETSYSTEMPROPERTY|COS|SQRT|EXITAPPLICATION2|ISDEVTOOL|SLEEP|ASIND|SELECT|POWER|NUMBERFORMAT|QUOTE|NULL|CE|TRUE|FALSE|BIT|DENSITY|DATETIME|TAB|REGEX|CRLF|CPI|FILE)(?:\$|\b)/i,

};


