{if $product.recurring_plans}
    {capture name="hide_form_changed"}Y{/capture}
    {capture name="orig_val_hide_form"}{$smarty.capture.val_hide_form nofilter}{/capture}
    {capture name="val_hide_form"}Y{/capture}
    {capture name="val_capture_options_vs_qty"}Y{/capture}
    {capture name="val_capture_buttons"}Y{/capture}
    {capture name="val_separate_buttons"}{/capture}
{/if}