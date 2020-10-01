package com.apps.client.juan.hugomed.helpers;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Typeface;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.TextPaint;
import android.text.style.MetricAffectingSpan;
import android.text.style.StyleSpan;
import android.text.style.TextAppearanceSpan;
import android.text.style.TypefaceSpan;
import android.util.Log;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.core.content.res.ResourcesCompat;

import com.apps.client.juan.hugomed.R;

import java.lang.reflect.Type;

public class SpannableHelper {

    Context mContext;
    public static final SpannableHelper shared = new SpannableHelper();
    private SpannableHelper() {

    }

    public SpannableString getSpannableString(String text, int attributesStyle, Context context) {
        mContext = context;
        SpannableString spannable = new SpannableString(text);
        int[] location = getSpanLocation(text.length(), attributesStyle);
        appleTextAppearance(spannable, location, attributesStyle);
        applyFontOnLocation(spannable, location, attributesStyle);
      //
        return spannable;
    }

    private void appleTextAppearance(SpannableString spannable, int[] location, int attributesStyle) {
        spannable.setSpan(new TextAppearanceSpan(mContext, attributesStyle), location[Location_SPAN.START.ordinal()], location[Location_SPAN.END.ordinal()], Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
    }

    private void applyFontOnLocation(SpannableString spannable, int[] location, int attributesStyle) {
        TypedArray attrs = mContext.obtainStyledAttributes(attributesStyle, new int[] {android.R.attr.fontFamily});
        int resource = attrs.getResourceId(0, R.font.gothamhtfmedium);
        Typeface typeface = ResourcesCompat.getFont(mContext, resource);
        spannable.setSpan(new FontSpan(typeface), location[Location_SPAN.START.ordinal()], location[Location_SPAN.END.ordinal()], Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
    }

    int[] getSpanLocation(int totalLength, int resource) {
        TypedArray attrs = mContext.obtainStyledAttributes(resource, new int[] {R.attr.location_1});
        String[] location1 = attrs.getString(0).split(",");
        int start = Integer.parseInt(location1[0]);
        int end = Integer.parseInt(location1[1]);
        if (start < 0) {
            start = totalLength + start;
            if (end <= 0) {
                end = totalLength;
            }
            else {
                end = start+end;
            }
        }
        else {
            if (end > 0) {
                end = start + end;
            }
            else if (end == 0) {
                end = totalLength;
            }
            else {
                end = totalLength+end;
            }
        }
        return new int[] {
                start, end
        };
    }

    enum Location_SPAN {
        START, END;
    }

    static class FontSpan extends MetricAffectingSpan {

        Typeface newType;
        public FontSpan(Typeface type) {
            super();
            newType = type;
        }

        @Override
        public void updateMeasureState(@NonNull TextPaint textPaint) {
            updateTypeface(textPaint);
        }

        @Override
        public void updateDrawState(TextPaint textPaint) {
            updateTypeface(textPaint);
        }

        void updateTypeface(TextPaint paint) {
            paint.setTypeface(newType);
        }
    }
}


