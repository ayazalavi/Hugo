package com.apps.client.juan.hugomed.helpers;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;

import com.apps.client.juan.hugomed.R;

public class ReceiptDotsView extends View {
    public ReceiptDotsView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        int circleWidth = 10;
        int circleHeight = 20;
        int centerCanvas = canvas.getHeight()/2;
        int canvasWidth = canvas.getWidth();
        Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        paint.setColor(getResources().getColor(R.color.light_pink));
        paint.setStrokeWidth(1);
        Log.v("canvas", canvas.getWidth()+"");
        Log.v("canvas", canvas.getHeight()+"");

        for (int i = 0; i <= canvasWidth; i=i+16) {
            if (i == 0) {
                canvas.drawCircle(i, centerCanvas, 10, paint);
            }
            else if (i > canvasWidth-16){
                canvas.drawCircle(canvasWidth, centerCanvas, 10, paint);
            }
            else {
                canvas.drawLine(i, centerCanvas, i+8, centerCanvas, paint);
            }
            Log.v("i-", ""+i+", "+canvasWidth);
        }
    }
}
