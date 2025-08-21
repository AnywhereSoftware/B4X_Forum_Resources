package flm.b4a.maskededittext;

import android.text.Editable;
import android.text.Html;
import android.text.InputFilter;
import android.text.InputType;
import android.text.Spanned;
import android.text.TextWatcher;
import android.text.method.PasswordTransformationMethod;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.TextView;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.keywords.Common.DesignerCustomView;
import anywheresoftware.b4a.objects.CustomViewWrapper;
import anywheresoftware.b4a.objects.LabelWrapper;
import anywheresoftware.b4a.objects.PanelWrapper;
import anywheresoftware.b4a.objects.TextViewWrapper;

@BA.ActivityObject
@BA.ShortName("MaskedEditText")
@BA.Events(values = {
		"EnterPressed",
		"Filter(NewText As String, Position As Int, Replace As Boolean) As String",
		"FocusChanged(HasFocus As Boolean)",
		"TextChanged(Old As String, New As String)"
})
@BA.Version(1.52F)
@BA.Author("Frédéric Leneuf-Magaud")
@BA.DesignerProperties(values = {
		@BA.Property(key="FloatingHint", displayName="FloatingHint", defaultValue="False", fieldType="Boolean"),
		@BA.Property(key="ForceDoneButton", displayName="ForceDoneButton", defaultValue="False", fieldType="Boolean"),
		@BA.Property(key="Format", displayName="Format", defaultValue="", fieldType="String", description="Mask characters: #=Digit, L=Letter, A=Alphanumeric, H=Hexadecimal, ?=Any character."),
		@BA.Property(key="Hint", displayName="Hint", defaultValue="", fieldType="String"),
		@BA.Property(key="InputType", displayName="InputType", defaultValue="INPUT_TYPE_TEXT", fieldType="String", list="INPUT_TYPE_NONE|INPUT_TYPE_NUMBERS|INPUT_TYPE_NUMBERS_WITH_SIGN|INPUT_TYPE_DECIMAL_NUMBERS|INPUT_TYPE_PHONE|INPUT_TYPE_TEXT|INPUT_TYPE_TEXT_WITH_CAPS"),
		@BA.Property(key="PasswordMode", displayName="PasswordMode", defaultValue="False", fieldType="Boolean"),
		@BA.Property(key="Placeholder", displayName="Placeholder", defaultValue="_", fieldType="String"),
		@BA.Property(key="ReadOnly", displayName="ReadOnly", defaultValue="False", fieldType="Boolean"),
		@BA.Property(key="SingleLine", displayName="SingleLine", defaultValue="False", fieldType="Boolean"),
		@BA.Property(key="WithSuggestions", displayName="WithSuggestions", defaultValue="False", fieldType="Boolean"),
		@BA.Property(key="Wrap", displayName="Wrap", defaultValue="True", fieldType="Boolean")
})
public class MaskedEditTextWrapper extends TextViewWrapper<MaskedEditText> implements TextWatcher, DesignerCustomView
{
	private String NomEvt;

	@BA.Hide
	public void innerInitialize(final BA ba, final String eventName, boolean keepOldObject)
	{
		this.ba = ba;
		if (!keepOldObject)
			setObject(new MaskedEditText(ba.context));
		super.innerInitialize(ba, eventName, true);
		getObject().m_ba = ba;

		NomEvt = eventName;

		// Gestion de l'évènement EnterPressed
		if (ba.subExists(eventName + "_enterpressed")) {
			getObject().setOnEditorActionListener(new TextView.OnEditorActionListener() {
				@Override
				public boolean onEditorAction(TextView v, int actionId, KeyEvent event)
				{
					ba.raiseEvent(getObject(), eventName + "_enterpressed", new Object[0]);
					return false;
				}
			});
		}

		// Gestion de l'évènement FocusChanged
		getObject().setOnFocusChangeListener(new TextView.OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus)
			{
				MaskedEditText met = getObject();
				if (met.lblHint != null) {
					if (hasFocus)
						met.lblHint.setTextColor(met.lblHint.getTextColors().withAlpha(255));
					else
						met.lblHint.setTextColor(met.lblHint.getTextColors().withAlpha((int) (255 * 0.4f)));
				}
				if (ba.subExists(eventName + "_focuschanged"))
					ba.raiseEvent(met, eventName + "_focuschanged", new Object[] { hasFocus });
			}
		});

		// Ajout d'un TextWatcher pour l'évènement TextChanged
		getObject().addTextChangedListener(this);

		// Gestion de l'évènement Filter
		if (ba.subExists(eventName + "_filter")) {
			getObject().setFilters(new InputFilter[] {new InputFilter() {
				@Override
				public CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend) {
					//BA.Log("Filter Src="+source.toString() + " Start,end="+start+","+end + " Dst=" + dest.toString() + " DStart,end=" + dstart+","+dend + " add="+(start+end+dstart+dend));
					if (!InternalChange && (start+end+dstart+dend) != 0) {
						return (String) ba.raiseEvent(getObject(), eventName + "_filter", new Object[] { source.toString(), dstart, Boolean.valueOf(dend - dstart > 0) });
					}
					return null;
				}
			}});
		}

		// InputType par défaut
		setInputType(InputType.TYPE_CLASS_TEXT);
	}

	/**
	 * By default the OS sets the virtual keyboard action key to display Done or Next according to the specific layout.
	 * You can force it to display Done by setting this value to True.
	 */
	public void setForceDoneButton(boolean value)
	{
		if (value)
			getObject().setImeOptions(EditorInfo.IME_ACTION_DONE);
		else
			getObject().setImeOptions(EditorInfo.IME_ACTION_UNSPECIFIED);
	}

	/**
	 * Gets or sets the text that will appear when the EditText is empty.
	 */
	public String getHint()
	{
		CharSequence c = getObject().getHint();
		return c == null ? "" : c.toString();
	}
	public void setHint(String text)
	{
		MaskedEditText met = getObject();
		met.setHint(text);
		if (met.lblHint != null)
			met.lblHint.setText(text);
	}

	/**
	 * Gets or sets the hint text color.	
	 */
	public int getHintColor()
	{
		return getObject().getCurrentHintTextColor();
	}
	public void setHintColor(int Color)
	{
		MaskedEditText met = getObject();
		met.setHintTextColor(Color);
		met.m_CustomHintColor = true;
		if (met.lblHint != null)
			met.lblHint.setTextColor(Color);
	}

	/**
	 * A floating hint is a hint that moves above the EditText when the user starts typing.
	 */
	public void EnableFloatingHint(BA ba)
	{
		MaskedEditText met = getObject();
		if (met.lblHint == null) {
			met.lblHint = new TextView(ba.context);
			met.lblHint.setText(getObject().getHint());
			met.lblHint.setVisibility(View.INVISIBLE);
			if (met.getParent() != null) {
				met.CreerFloatingHint();
				met.AnimerFloatingHint(getText().length() > 0);
			}
		}
	}

	/**
	 * Sets whether the text content will wrap within the EditText bounds. Relevant when the EditText is in multiline mode.
	 */
	public void setWrap(boolean value)
	{
		getObject().setHorizontallyScrolling(!value);
	}

	private static boolean IsMaskCar(char Car)
	{
		return (Car == '#' || Car == 'L' || Car == 'A' || Car == 'H' || Car == '?');
	}

	/**
	 * Gets or sets the input mask.
	 * Mask characters:
	 * # = Digit
	 * L = Letter
	 * A = Alphanumeric
	 * H = Hexadecimal
	 * ? = Any character
	 * Examples:
	 * - Date &amp; time = "##/##/#### ##:##"
	 * - Phone number = "(###) ###-####"
	 * - IP address = "###.###.###.###"
	 * - MAC address = "HH:HH:HH:HH:HH:HH"
	 * - Parental lock password = "AAAA"
	 */
	public String getFormat()
	{
		return getObject().m_Format;
	}
	public void setFormat(String Format)
	{
		getObject().m_Format = Format;
		if (Format.length() > 0) {
			// Création du masque
			char Car;
			StringBuilder Mask = new StringBuilder("");
			for (int i = 0; i < Format.length(); i++) {
				Car = Format.charAt(i);
				if (IsMaskCar(Car))
					Mask.append(getObject().m_Placeholder); 
				else
					Mask.append(Car); 
			}

			// Affichage du masque
			InternalChange = true;
			//BA.Log("Initialisation du masque: " + Mask.toString());
			String TexteActuel = getText().toString();
			int Pos = getObject().getSelectionStart();
			getObject().setText(Mask.toString());
			getObject().setSelection(Math.min(Pos, Mask.length()));
			InternalChange = false;
			if (TexteActuel.length() > 0) {
				//BA.Log("Ajout du texte: " + TexteActuel);
				getObject().setSelection(0);
				setText(TexteActuel);
			}
		}
		if (getObject().m_AvecSuggestions)
			setInputType(getObject().getInputType());
	}

	/**
	 * Gets or sets the placeholder character for the input mask.
	 * Default = '_'
	 */
	public char getPlaceholder()
	{
		return getObject().m_Placeholder;
	}
	public void setPlaceholder(char Placeholder)
	{
		if (getObject().m_Format.length() > 0) {
			InternalChange = true;
			getObject().setText(getText().replace(getPlaceholder(), Placeholder));
			InternalChange = false;
		}
		getObject().m_Placeholder = Placeholder;
	}

	/**
	 * Gets or sets whether the EditText is editable.
	 * Default = False
	 */
	public boolean getReadOnly()
	{
		return getObject().m_LectureSeule;
	}
	public void setReadOnly(boolean ReadOnly)
	{
		getObject().m_LectureSeule = ReadOnly;
	}

	/**
	 * Sets whether the EditText should be in password mode and hide the actual characters.
	 * Default = False
	 */
	public void setPasswordMode(boolean PasswordMode)
	{
		getObject().m_PasswordMode = PasswordMode;
		setInputType(getObject().getInputType());
	}

	/**
	 * Sets whether the virtual keyboard displays any dictionary-based candidates.
	 * This setting is automatically set to False if Format is not empty or there's a handler for the Filter event (this incompatibility is due to a bug in ICS and JellyBean).
	 * This setting is ignored when InputType is Numbers or Phone, or when PasswordMode is True.
	 * Default = False
	 */
	public void setWithSuggestions(boolean value)
	{
		getObject().m_AvecSuggestions = value;
		setInputType(getObject().getInputType());
	}

	/**
	 * Sets whether the EditText should be in single line mode or multiline mode.
	 * Default = False
	 */
	public void setSingleLine(boolean singleLine)
	{
		getObject().m_SingleLine = singleLine;
		setInputType(getObject().getInputType());
	}

	public static final int INPUT_TYPE_NONE = InputType.TYPE_NULL;
	public static final int INPUT_TYPE_NUMBERS = InputType.TYPE_CLASS_NUMBER;
	public static final int INPUT_TYPE_NUMBERS_WITH_SIGN = InputType.TYPE_CLASS_NUMBER|InputType.TYPE_NUMBER_FLAG_SIGNED;
	public static final int INPUT_TYPE_DECIMAL_NUMBERS = INPUT_TYPE_NUMBERS_WITH_SIGN|InputType.TYPE_NUMBER_FLAG_DECIMAL;
	public static final int INPUT_TYPE_PHONE = InputType.TYPE_CLASS_PHONE;
	public static final int INPUT_TYPE_TEXT = InputType.TYPE_CLASS_TEXT;
	public static final int INPUT_TYPE_TEXT_WITH_CAPS = InputType.TYPE_CLASS_TEXT|InputType.TYPE_TEXT_FLAG_CAP_SENTENCES;

	/**
	 * Gets or sets the input type flag. This flag is used to determine the settings of the virtual keyboard.
	 * The value is one of the INPUT_TYPE constants.
	 */
	public void setInputType(int value)
	{
		if (getObject().m_PasswordMode && (value & INPUT_TYPE_TEXT) == INPUT_TYPE_TEXT) {
			if ((value & InputType.TYPE_TEXT_VARIATION_PASSWORD) != InputType.TYPE_TEXT_VARIATION_PASSWORD)
				value |= InputType.TYPE_TEXT_VARIATION_PASSWORD;
		}
		else if ((value & InputType.TYPE_TEXT_VARIATION_PASSWORD) == InputType.TYPE_TEXT_VARIATION_PASSWORD)
			value &= ~InputType.TYPE_TEXT_VARIATION_PASSWORD;
		if (value != INPUT_TYPE_NONE 
				&& (!getObject().m_AvecSuggestions || getObject().m_PasswordMode || getObject().m_Format.length() > 0 || ba.subExists(NomEvt + "_filter"))) {
			if ((value & InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS) != InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS)
				value |= InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS;
			if (!getObject().m_PasswordMode && (value & INPUT_TYPE_TEXT) == INPUT_TYPE_TEXT) {
				// Workaround pour les appareils Samsung
				if ((value & InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD) != InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD)
					value |= InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD;
			}
		}
		else {
			if ((value & InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS) == InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS)
				value &= ~InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS;
			if ((value & InputType.TYPE_TEXT_VARIATION_URI) == InputType.TYPE_TEXT_VARIATION_URI)
				value &= ~InputType.TYPE_TEXT_VARIATION_URI;
			if ((value & InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD) == InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD)
				value &= ~InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD;
		}
		InternalChange = true;
		getObject().setInputType(value);
		getObject().setSingleLine(getObject().m_SingleLine);
		if (getObject().m_PasswordMode)
			getObject().setTransformationMethod(PasswordTransformationMethod.getInstance());
		else if (!getObject().m_SingleLine)
			getObject().setTransformationMethod(null);
		InternalChange = false;
	}
	public int getInputType()
	{
		return getObject().getInputType();
	}

	private boolean InternalChange = false;
	private String Avant = "";
	private int Position = 0;
	private int lgrInsertion = 0;
	private int lgrRemplacement = 0;

	@BA.Hide
	@Override
	public void beforeTextChanged(CharSequence s, int start, int count, int after)
	{
		if (!InternalChange) {
			Avant = s.toString();
			Position = start;
			lgrRemplacement = count;
			lgrInsertion = after; 
			//BA.Log("Avant="+Avant + " Position="+Position + " Insertion=" + lgrInsertion + " Remplacement=" + lgrRemplacement);
		}
	}

	@BA.Hide
	@Override
	public void onTextChanged(CharSequence s, int start, int before, int count)
	{ // Not used
	}

	private void Formater(String Remplacement, StringBuilder NouvText, int LongueurSaisie)
	{
		//BA.Log("Remplacement de caractères ("+Remplacement+") " + Remplacement.length());
		char Car, mskCar;
		int idxCar = 0;
		for (int idxMask = NouvText.length(); idxMask < getObject().m_Format.length(); idxMask++) {
			mskCar = getObject().m_Format.charAt(idxMask);
			if (idxCar >= Remplacement.length())
				break;
			Car = Remplacement.toLowerCase().charAt(idxCar);
			switch (mskCar) {
			case '#': // Nombre
				if ((Car >= '0' && Car <= '9') || (Car == getObject().m_Placeholder)) {
					NouvText.append(Car);
					if (LongueurSaisie > 0)
						Position++;
				}
				else
					idxMask--;
				LongueurSaisie--;
				break;
			case 'L': // Lettre
				if ((Car >= 'a' && Car <= 'z') || (Car == getObject().m_Placeholder)) {
					NouvText.append(Remplacement.charAt(idxCar));
					if (LongueurSaisie > 0)
						Position++;
				}
				else
					idxMask--;
				LongueurSaisie--;
				break;
			case 'A': // Alpha-numérique
				if ((Car >= '0' && Car <= '9') || (Car >= 'a' && Car <= 'z') || (Car == getObject().m_Placeholder)) {
					NouvText.append(Remplacement.charAt(idxCar));
					if (LongueurSaisie > 0)
						Position++;
				}
				else
					idxMask--;
				LongueurSaisie--;
				break;
			case 'H': // Hexadécimal
				if ((Car >= '0' && Car <= '9') || (Car >= 'a' && Car <= 'f') || (Car == getObject().m_Placeholder)) {
					NouvText.append(Remplacement.charAt(idxCar));
					if (LongueurSaisie > 0)
						Position++;
				}
				else
					idxMask--;
				LongueurSaisie--;
				break;
			case '?': // N'importe quel caractère
				NouvText.append(Remplacement.charAt(idxCar));
				if (LongueurSaisie > 0) {
					LongueurSaisie--;
					Position++;
				}
				break;
			default:
				// Caractère littéral
				if (Car == getObject().m_Format.toLowerCase().charAt(idxMask)) {
					NouvText.append(Remplacement.charAt(idxCar));
					LongueurSaisie--;
				}
				else {
					NouvText.append(mskCar);
					idxCar--;
				}
				if (LongueurSaisie > 0)
					Position++;
			}
			idxCar++;
		}
	}

	@BA.Hide
	@Override
	public void afterTextChanged(Editable E)
	{
		if (!InternalChange && !Avant.equals(E.toString())) {
			InternalChange = true;
			//BA.Log("Internal change (LS=" + getObject().m_LectureSeule + ")");

			MaskedEditText met = getObject();
			if (met.m_LectureSeule) {
				// Rejet des changements
				int Pos = Position;
				E.clear();
				if (E.getFilters().length > 0) {
					InputFilter[] IF = E.getFilters();
					E.setFilters(new InputFilter[0]);
					E.append(Avant);
					//BA.Log("E="+E.toString());
					E.setFilters(IF);
				}
				else
					E.append(Avant);
				met.setSelection(Pos);
				InternalChange = false;
				return;
			}

			// Hint flottant
			if (met.lblHint != null) {
				met.AnimerFloatingHint(E.length() > 0);
			}

			if (met.m_Format.length() > 0) {
				// Formatage de la saisie
				String Saisie = E.toString().substring(Position, Position + lgrInsertion);
				//BA.Log("NewChars=|"+Saisie+"|");
				StringBuilder Remplacement = new StringBuilder("");
				if (lgrRemplacement > 0) {
					// Remplacement/suppression de caractères
					Remplacement.append(Saisie.substring(0, Math.min(Saisie.length(), lgrRemplacement)));
					//BA.Log("Remplacement_R=|"+Remplacement.toString()+"| " + Remplacement.length());
				}
				for (int i = Position + lgrRemplacement; i < Avant.length(); i++) {
					if (IsMaskCar(met.m_Format.charAt(i)))
						Remplacement.append(Avant.charAt(i));
				}
				//BA.Log("Remplacement_C=|"+Remplacement.toString()+"| " + Remplacement.length());
				int Count = lgrInsertion - lgrRemplacement; 
				if (Count > 0) {
					// Insertion de caractères
					Remplacement.insert(lgrRemplacement, Saisie.substring(lgrRemplacement, lgrInsertion));
					//BA.Log("+" + Saisie.substring(lgrRemplacement, lgrInsertion));
					//BA.Log("Remplacement_I=|"+Remplacement.toString()+"| " + Remplacement.length());
				}
				for (int i = Remplacement.length(); i < met.m_Format.length(); i++) {
					Remplacement.append(met.m_Placeholder);
				}
				StringBuilder NewText = new StringBuilder(Avant.substring(0, Position));
				Formater(Remplacement.toString(), NewText, Saisie.length());

				// Fin du masque
				char mskCar;
				for (int i = NewText.length(); i < met.m_Format.length(); i++) {
					mskCar = met.m_Format.charAt(i);
					if (IsMaskCar(mskCar))
						NewText.append(met.m_Placeholder); 
					else
						NewText.append(mskCar); 
				}

				//BA.Log("NewText=|"+NewText+"| NewPos="+Position);

				// Mise à jour du texte
				E.clear();
				if (E.getFilters().length > 0) {
					InputFilter[] IF = E.getFilters();
					E.setFilters(new InputFilter[0]);
					E.append(NewText);
					//BA.Log("E="+E.toString());
					E.setFilters(IF);
				}
				else
					E.append(NewText);
				//BA.Log("getText=|"+getText().toString()+"| NewPos="+Math.min(Position, NewText.length()));
				met.setSelection(Math.min(Position, NewText.length()));
				InternalChange = false;
				if (ba.subExists(NomEvt + "_textchanged"))
					ba.raiseEvent(met, NomEvt + "_textchanged", new Object[] { Avant, NewText.toString() });
				return;
			}

			InternalChange = false;
			if (ba.subExists(NomEvt + "_textchanged"))
				ba.raiseEvent(met, NomEvt + "_textchanged", new Object[] { Avant, E.toString() });
		}
	}

	/**
	 * Gets or sets the text.
	 * Ignores the ReadOnly setting.
	 */
	@Override
	public String getText()
	{
		return getObject().getText().toString();
	}
	@Override
	public void setText(Object Text)
	{
		if (!InternalChange) {
			MaskedEditText met = getObject();
			boolean ResetLectureSeule = met.m_LectureSeule; 
			met.m_LectureSeule = false;
			//BA.Log("Set text to " + Text);
			if (Text instanceof CharSequence)
				met.setText((CharSequence) Text);
			else
				met.setText(Text.toString());
			if (ResetLectureSeule)
				met.m_LectureSeule = true;

			// Hint flottant
			if (met.lblHint != null) {
				met.AnimerFloatingHint(getText().length() > 0);
			}
		}
	}

	/** Replaces the text with a conversion of the provided HTML string. */ 
	public void SetFromHTML(String HTML)
	{
		setText(Html.fromHtml(HTML));
	}

	/**
	 * Returns a copy of the text without the leading and trailing spaces, and without the placeholders if Format is not empty.
	 */
	public String getCompactText()
	{
		if (getObject().m_Format.length() > 0) {
			StringBuilder Compact = new StringBuilder("");
			char mskCar, txtCar;
			for (int i = 0; i < getObject().m_Format.length(); i++) {
				if (i >= getText().length())
					break;
				mskCar = getObject().m_Format.charAt(i);
				txtCar = getText().charAt(i);
				if (IsMaskCar(mskCar)) {
					if (txtCar != '_')
						Compact.append(txtCar);
				}
				else
					Compact.append(txtCar);
			}
			return Compact.toString().trim();
		}
		else
			return getText().trim();
	}

	/**
	 * Gets or sets the selection start position (or the cursor position).
	 * Returns -1 if there is no selection or cursor.
	 */
	public int getSelectionStart()
	{
		return getObject().getSelectionStart();
	}
	public void setSelectionStart(int value) {
		getObject().setSelection(Math.min(value, getText().length()));
	}

	/**
	 * Gets the selection end position (or the cursor position).
	 * Returns -1 if there is no selection or cursor.
	 */
	public int getSelectionEnd()
	{
		return getObject().getSelectionEnd();
	}

	/**
	 * Selects the entire text.
	 */
	public void SelectAll()
	{
		getObject().selectAll();
	}

	/**
	 * Sets an icon and an error message that will be displayed in a popup when the EditText has focus.
	 * The icon and error message will be cleared if Message is empty or the text is modified.
	 */
	public void ShowError(String Message)
	{
		if (Message.length() == 0)
			getObject().setError(null);
		else
			getObject().setError(Message);
	}

	@Override
	public void setVisible(boolean Visible)
	{
		if (getObject().lblHint != null)
			getObject().lblHint.setVisibility(Visible ? View.VISIBLE : View.INVISIBLE);
		super.setVisible(Visible);
	}

	// ----------------------------- B4A CUSTOM VIEW WITH DESIGNER SUPPORT -----------------------------
	@BA.Hide
	@Override
	public void _initialize(BA ba, Object activityClass, String EventName)
	{
		Initialize(ba, EventName);
	}

	@Override
	public void DesignerCreateView(PanelWrapper base, LabelWrapper lw, anywheresoftware.b4a.objects.collections.Map props)
	{
		// Remplacement du Panel par le MaskedEditText
		setEnabled(base.getEnabled());
		setVisible(base.getVisible());
		if (base.getTag().toString().length() == 0)
			setTag(null);
		else
			setTag(base.getTag());
		CustomViewWrapper.replaceBaseWithView(base, getObject());

		// Mise à jour des propriétés
		setGravity(lw.getGravity());
		setText(lw.getText());
		setTypeface(lw.getTypeface());
		setTextSize(lw.getTextSize());
		setTextColor(lw.getTextColor());
		if ((boolean)props.Get("FloatingHint")) {
			BA ba = (BA) props.Get("ba");
			EnableFloatingHint(ba);
		}
		setForceDoneButton((boolean)props.Get("ForceDoneButton"));
		setFormat((String)props.Get("Format"));
		setHint((String)props.Get("Hint"));
		setPasswordMode((boolean)props.Get("PasswordMode"));
		String strPlaceholder = (String)props.Get("Placeholder");
		if (strPlaceholder.length() > 0)
			setPlaceholder(strPlaceholder.charAt(0));
		setReadOnly((boolean)props.Get("ReadOnly"));
		setSingleLine((boolean)props.Get("SingleLine"));
		setWithSuggestions((boolean)props.Get("WithSuggestions"));
		setWrap((boolean)props.Get("Wrap"));

		String InputType = (String)props.Get("InputType");
		if (InputType.equals("INPUT_TYPE_NONE"))
			setInputType(INPUT_TYPE_NONE);
		else if (InputType.equals("INPUT_TYPE_NUMBERS"))
			setInputType(INPUT_TYPE_NUMBERS);
		else if (InputType.equals("INPUT_TYPE_NUMBERS_WITH_SIGN"))
			setInputType(INPUT_TYPE_NUMBERS_WITH_SIGN);
		else if (InputType.equals("INPUT_TYPE_DECIMAL_NUMBERS"))
			setInputType(INPUT_TYPE_DECIMAL_NUMBERS);
		else if (InputType.equals("INPUT_TYPE_PHONE"))
			setInputType(INPUT_TYPE_PHONE);
		else if (InputType.equals("INPUT_TYPE_TEXT"))
			setInputType(INPUT_TYPE_TEXT);
		else if (InputType.equals("INPUT_TYPE_TEXT_WITH_CAPS"))
			setInputType(INPUT_TYPE_TEXT_WITH_CAPS);
	}
}
