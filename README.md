# nonConformance

Done as part of interview process.

When ever a case is created with Type 'problem' or when a case is updated to the type 'problem', a nonConformance record must be created.<br/>
If a nonConformance is a parent of Case.<br/>
When the nonConformance is created, its reference must be stored on the case.<br/>
The nonConformance must not be created if the case already has a nonConformance record.<br/>
The nonConformance record must only be created when the changes are triggered by a user who has the permission set 'Case Admin'.<br/>
The values in the nonConformance record will be copied from the case.<br/>
<br/>
                      Approach<br/>
Trigger on Case which will fire on before insert & before update.<br/>
Custom permission assigned to the permission set.<br/>
to check the permission set, use the below code<br/>
<br/>
  FeatureManagement.checkpermissionset('<name of the permission>')
