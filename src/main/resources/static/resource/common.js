$('select[data-value]').each(function(index, item) {
    const Editor = require('@toast-ui/editor');
    const items = $(item);

    const defaultValue = items.attr('data-value').trim();

    if (defaultValue.length > 0) {
        items.val(defaultValue);
    }
})