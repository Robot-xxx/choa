function downList(_this){
    $("#"+_this).chosen({
        disable_search_threshold: 0,
        no_results_text: '沒有此数据!',
        width: '50%',
        search_contains: true
    });
}