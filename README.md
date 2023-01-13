# nonConformance

Done as part of interview process.

When ever a case is created with Type 'problem' or when a case is updated to the type 'problem', a nonConformance record must be created.
If a nonConformance is a parent of Case.
When the nonConformance is created, its reference must be stored on the case.
The nonConformance must not be created if the case already has a nonConformance record.
The nonConformance record must only be created when the changes are triggered by a user who has the permission set 'Case Admin'.
The values in the nonConformance record will be copied from the case.

**********************Approach********************
Trigger on Case which will fire on before insert & before update.
Custom permission assigned to the permission set.
to check the permission set, use the below code

  FeatureManagement.checkpermissionset('<name of the permission>')
