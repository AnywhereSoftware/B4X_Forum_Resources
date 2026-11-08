B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
Sub Class_Globals

	Private ctxt As JavaObject
	Private jo As JavaObject

End Sub

Public Sub Initialize

	ctxt.InitializeContext
	jo.InitializeStatic("anywheresoftware.b4a.BA")

End Sub

Public Sub LaunchReviewFlow

	Try

		Dim manager As JavaObject

		manager = manager.InitializeStatic("com.google.android.play.core.review.ReviewManagerFactory") _
            .RunMethod("create", Array(ctxt))

		Dim requestTask As JavaObject
		requestTask = manager.RunMethod("requestReviewFlow", Null)

		Dim listener As Object
		listener = CreateReviewListener(manager)

		requestTask.RunMethod("addOnCompleteListener", Array(listener))

	Catch

		Log(LastException)

	End Try

End Sub

Private Sub CreateReviewListener(manager As JavaObject) As Object

	Return Me.As(JavaObject).RunMethod("createReviewListener", Array(manager))

End Sub


#if JAVA

import com.google.android.play.core.review.*;
import com.google.android.gms.tasks.*;

public Object createReviewListener(ReviewManager manager) {

    review_listener listener =
        new review_listener();

    listener.ba = ba;
    listener.manager = manager;

    return listener;
}

public static class review_listener
implements OnCompleteListener<ReviewInfo> {

    public anywheresoftware.b4a.BA ba;

    public ReviewManager manager;

    @Override
    public void onComplete(Task<ReviewInfo> task) {

        try {

            if(task.isSuccessful()) {

                ReviewInfo reviewInfo =
                    task.getResult();

                manager.launchReviewFlow(
                    ba.activity,
                    reviewInfo
                );

                android.util.Log.d(
                    "B4A",
                    "Review flow launched"
                );

            } else {

                android.util.Log.d(
                    "B4A",
                    "Review flow failed"
                );
            }

        } catch(Exception e) {

            android.util.Log.e(
                "B4A",
                e.toString()
            );
        }
    }
}

#End If