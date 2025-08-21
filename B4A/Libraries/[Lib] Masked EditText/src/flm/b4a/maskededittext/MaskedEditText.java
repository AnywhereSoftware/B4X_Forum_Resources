package flm.b4a.maskededittext;

import android.content.Context;
import android.text.ClipboardManager;
import android.text.Editable;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.AlphaAnimation;
import android.view.animation.AnimationSet;
import android.view.animation.TranslateAnimation;
import android.widget.EditText;
import android.widget.TextView;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.objects.PanelWrapper;

@BA.Hide
public class MaskedEditText extends EditText
{
	BA m_ba;
	String m_Format = "";
	char m_Placeholder = '_';
	boolean m_LectureSeule = false;
	boolean m_PasswordMode = false;
	boolean m_SingleLine = false;
	boolean m_AvecSuggestions = false;
	boolean m_CustomHintColor = false;
	TextView lblHint;

	public MaskedEditText(Context context)
	{
		super(context);
	}

	private int getHauteurHint()
	{
		// Calcule la hauteur du hint flottant
		BALayout.LayoutParams lp = (BALayout.LayoutParams) getLayoutParams();
		int widthMeasureSpec = MeasureSpec.makeMeasureSpec(lp.width, MeasureSpec.EXACTLY);
		int heightMeasureSpec = MeasureSpec.makeMeasureSpec(0, MeasureSpec.UNSPECIFIED);
		lblHint.measure(widthMeasureSpec, heightMeasureSpec);
		return lblHint.getMeasuredHeight();
	}

	void CreerFloatingHint()
	{
		// Ajoute l'hint flottant au-dessus de l'EditText
		final PanelWrapper pnlParent = new PanelWrapper();
		pnlParent.setObject((ViewGroup) getParent());
		BALayout.LayoutParams lp = (BALayout.LayoutParams) getLayoutParams();
		pnlParent.AddView(lblHint, lp.left, Math.max(0, lp.top - getHauteurHint()), lp.width, ViewGroup.LayoutParams.WRAP_CONTENT);
	}

	void AnimerFloatingHint(boolean PrésenceTexte)
	{
		// Actualise les propriétés du hint flottant et anime son apparition/disparition
		if (lblHint.getParent() != null) {
			boolean AnimApparition = false;
			boolean AnimDisparition = false;
			if (PrésenceTexte || m_Format.length() > 0) {
				lblHint.setGravity(getGravity());
				lblHint.setPadding(getPaddingLeft(), 0, getPaddingRight(), 0);
				lblHint.setTextAppearance(m_ba.context, android.R.style.TextAppearance_Small);
				if (m_CustomHintColor)
					lblHint.setTextColor(getCurrentHintTextColor());
				if (lblHint.getVisibility() == View.INVISIBLE) {
					// Apparition animée du hint
					AnimApparition = true;
					lblHint.setVisibility(View.VISIBLE);
				}
			}
			else {
				if (lblHint.getVisibility() == View.VISIBLE) {
					// Disparition animée du hint
					AnimDisparition = true;
					lblHint.setVisibility(View.INVISIBLE);
				}
			}
			if (AnimApparition) {
				TranslateAnimation TranslAnim = new TranslateAnimation(0, 0, getHauteurHint(), 0);
				AlphaAnimation AlphaAnim = new AlphaAnimation(0, isFocused() ? 1 : 0.4f);
				AnimationSet AnimSet = new AnimationSet(false);
				AnimSet.addAnimation(TranslAnim);
				AnimSet.addAnimation(AlphaAnim);
				AnimSet.setDuration(250);
				lblHint.startAnimation(AnimSet);
			}
			else if (AnimDisparition) {
				TranslateAnimation TranslAnim = new TranslateAnimation(0, 0, 0, getHauteurHint());
				AlphaAnimation AlphaAnim = new AlphaAnimation(isFocused() ? 1 : 0.4f, 0);
				AnimationSet AnimSet = new AnimationSet(false);
				AnimSet.addAnimation(TranslAnim);
				AnimSet.addAnimation(AlphaAnim);
				AnimSet.setDuration(100);
				lblHint.startAnimation(AnimSet);
			}
		}
	}

	@Override
	protected void onLayout(boolean changed, int left, int top, int right, int bottom)
	{
		//BA.Log("--- onLayout:" + left +","+ top+"," + right+"," + bottom);
		if (lblHint != null && getParent() != null) {
			if (lblHint.getParent() == null) {
				// Ajoute l'hint flottant au-dessus de l'EditText
				CreerFloatingHint();
			}
			else {
				// Actualise la position de l'hint flottant
				BALayout.LayoutParams lp = (BALayout.LayoutParams) lblHint.getLayoutParams();
				if (lp.left != left) {
					lp.left = left;
				}
				int NewTop = top - getHauteurHint();
				if (lp.top != NewTop) {
					lp.top = NewTop;
				}
			}
			AnimerFloatingHint(getText().length() > 0);
		}
	}

	@Override
	public boolean onTextContextMenuItem(int id)
	{
		if (id == android.R.id.paste) {
			// Collage du contenu du presse-papiers
			ClipboardManager cm = (ClipboardManager) BA.applicationContext.getSystemService(Context.CLIPBOARD_SERVICE);
			Editable E = getText();
			if (getSelectionStart() == getSelectionEnd()) {
				// Insertion
				E.insert(getSelectionStart(), cm.getText());
			}
			else {
				// Remplacement
				E.replace(getSelectionStart(), getSelectionEnd(), cm.getText());				
			}
			return true;
		}
		else
			return super.onTextContextMenuItem(id);
	}
}
