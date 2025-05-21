var CurrentSituation
var CurrentProp 
var CurrentLife 
var adv 
var codeText = ""
var codeNumber = ""

const keyMappings = [
    { key: "0", keyCode: 48, code: "Digit0" },
    { key: "1", keyCode: 49, code: "Digit1" },
    { key: "2", keyCode: 50, code: "Digit2" },
    { key: "3", keyCode: 51, code: "Digit3" },
    { key: "4", keyCode: 52, code: "Digit4" },
    { key: "5", keyCode: 53, code: "Digit5" },
    { key: "6", keyCode: 54, code: "Digit6" },
    { key: "7", keyCode: 55, code: "Digit7" },
    { key: "8", keyCode: 56, code: "Digit8" },
    { key: "9", keyCode: 57, code: "Digit9" },
    // Numpad keys
    { key: "0", keyCode: 96, code: "Numpad0" },
    { key: "1", keyCode: 97, code: "Numpad1" },
    { key: "2", keyCode: 98, code: "Numpad2" },
    { key: "3", keyCode: 99, code: "Numpad3" },
    { key: "4", keyCode: 100, code: "Numpad4" },
    { key: "5", keyCode: 101, code: "Numpad5" },
    { key: "6", keyCode: 102, code: "Numpad6" },
    { key: "7", keyCode: 103, code: "Numpad7" },
    { key: "8", keyCode: 104, code: "Numpad8" },
    { key: "9", keyCode: 105, code: "Numpad9" }
];




function OpenCode(data) {
    $("#interact_ui").html('');

}



function OpenInteract(data) {
    $("#interact_ui").html('');

    if (data.bars) {
        $.each(data.bars, function (index, item) {
            var label_component_id = "label_component_bar" + index

            $("#interact_ui").append('<div class ="label_component" id="'+ label_component_id +'"></div>');

            var labelLeft = item.labelLeft
            var labelRight = item.val + "/" + item.max

            $("#" + label_component_id).append('<div class ="label_left">' + labelLeft + '</div>');
            $("#" + label_component_id).append('<div class ="label_right">' + labelRight + '</div>');

            var bar_component_id = "bar_component_background_" + index
            $("#interact_ui").append('<div class ="box_component" id="' + bar_component_id + '">');

            $("#" + bar_component_id).css("height","1.0vh");

            var bar_val_id = "bar_val_" + index
            $("#" + bar_component_id).append('<div class ="bar_val" id="' + bar_val_id + '">');

            var barValue = (item.val / item.max) * 100
           
            $("#" + bar_val_id).css("width","" + barValue + "%");

            if (item.color) {
                $("#" + bar_val_id).css("background-color",item.color);
            } 
        });
    }


    if (data.actions) {
        var label_component_id = "label_component_action"
        $("#interact_ui").append('<div class ="label_component" id="'+ label_component_id +'"></div>');
        var labelLeft = "Actions"
        var labelRight = ""
        $("#" + label_component_id).append('<div class ="label_left">' + labelLeft + '</div>');
        $("#" + label_component_id).append('<div class ="label_right">' + labelRight + '</div>');
        
        var box_component_id = "box_component_actions"
        $("#interact_ui").append('<div class ="box_component" id="' + box_component_id + '">');

        $.each(data.actions, function (index, item) {
            var img_box_id = "img_box_" + index 

            $("#" + box_component_id).css("background-color","rgba(220, 131, 15, 0.0)")

            $("#" + box_component_id).append('<div class ="img_box transparent" id="' + img_box_id + '">')
            
            var img_url = 'url("' + item.img + '.png")'
            $("#" + img_box_id).css("background-image",img_url)

            $("#" + img_box_id).click(function() {
                $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({id: CurrentProp, action: item.action, extra: data, labelLeft: item.description.labelLeft}));
            });

            if (item.description) {
                $("#" + img_box_id).mouseenter(function() {
                    if (item.description.labelLeft) {
                        $("#label_component_dec_label_left").html(item.description.labelLeft)
                    }
                    if (item.description.labelRight) {
                        $("#label_component_dec_label_right").html(item.description.labelRight)
                    }
                    if (item.description.items) {
                        $("#box_component_description").html('')
                        $.each(item.description.items, function (index, item) {
                            var img_box_id2 = "img_box2_" + index 
                            $("#box_component_description").append('<div class ="img_box transparent" id="' + img_box_id2 + '">')
            
                            var img_url2 = 'url("items/' + item.name + '.png")'
                            $("#" + img_box_id2).css("background-image",img_url2)

                            $("#" + img_box_id2).css("height","5vh")
                            $("#" + img_box_id2).css("width","5vh")


                            
                            $("#" + img_box_id2).append('<div class ="label_item_count">x' + item.count + '</div>')
                            
                        })
                    }

                    $("#" + img_box_id).css("height","10vh")
                    $("#" + img_box_id).css("width","10vh")
                    $("#" + img_box_id).css("margin","0vh")
                });

                $("#" + img_box_id).mouseleave(function() {

                    $("#" + img_box_id).css("height","8vh")
                    $("#" + img_box_id).css("width","8vh")
                    $("#" + img_box_id).css("margin","1vh")

                    $("#label_component_dec_label_left").html('')
                    $("#box_component_description").html('')
                });
            }
        });
    }

    var label_component_id = "label_component_dec"
    $("#interact_ui").append('<div class ="label_component" id="'+ label_component_id +'"></div>');
    var labelLeft = ""
    var labelRight = ""

    $("#" + label_component_id).append('<div class ="label_left" id="' + label_component_id + '_label_left' + '">' + labelLeft + '</div>');
    $("#" + label_component_id).append('<div class ="label_right" id="' + label_component_id + '_label_right' + '">' + labelRight + '</div>');

    var box_component_id = "box_component_description"
    $("#interact_ui").append('<div class ="box_component" id="' + box_component_id + '">');

    $("#" + box_component_id).css("background-color","rgba(220, 131, 15, 0.0)")

    CurrentProp = data.PropId       
}   

function OpenStorage(data) {
    $("#interact_ui").html('');

    var label_component_id = "label_component_dec"
    $("#interact_ui").append('<div class ="label_component" id="'+ label_component_id +'"></div>');
    var labelLeft = data.labelLeft
    var labelRight = ""

    $("#" + label_component_id).append('<div class ="label_left" id="' + label_component_id + '_label_left' + '">' + labelLeft + '</div>');
    $("#" + label_component_id).append('<div class ="label_right" id="' + label_component_id + '_label_right' + '">' + labelRight + '</div>');

    var box_component_id = "box_component_description"
    $("#interact_ui").append('<div class ="box_component" id="' + box_component_id + '">');

    $("#" + box_component_id).css("height","20vh")

    $("#" + box_component_id).css("overflow","auto")

    $.each(data.items, function (index, item) {
        var img_box_id2 = "img_box2_" + index 
        $("#box_component_description").append('<div class ="img_box transparent" id="' + img_box_id2 + '">')

        var img_url2 = 'url("items/' + item.name + '.png")'
        $("#" + img_box_id2).css("background-image",img_url2)

        // $("#" + img_box_id2).css("height","5vh")
        // $("#" + img_box_id2).css("width","5vh")



        // if (item.count ) {
        var countValues = item.count + "/" + item.limit
        $("#" + img_box_id2).append('<div class ="label_item_count">' + countValues + '</div>')



        $("#" + img_box_id2).append('<div class ="add_remove_button" id ="' + img_box_id2 + '_add">+</div>')
        $("#" + img_box_id2 + "_add").css("right","0vh")
        $("#" + img_box_id2).append('<div class ="add_remove_button" id ="' + img_box_id2 + '_remove">-</div>')
        $("#" + img_box_id2 + "_remove").css("left","0vh")

        $("#" + img_box_id2 + "_remove").click(function() {
            var count = $("#" + "box_component_count").val()
          
            $.post(`https://${GetParentResourceName()}/itemManagement`, JSON.stringify({id: data.PropId, item: item.name, count:  count,action: "remove",labelLeft: data.labelLeft}));
        });
        $("#" + img_box_id2 + "_add").click(function() {
            var count = $("#" + "box_component_count").val()
            
            $.post(`https://${GetParentResourceName()}/itemManagement`, JSON.stringify({id: data.PropId, item: item.name, count: count,action: "add",labelLeft: data.labelLeft}));
        });
            
      
    })



    var box_component_count_id = "box_component_count"
    $("#interact_ui").append('<input type="number" min="1" name="Count" placeholder="Choose Quantity" class ="box_component" id="' + box_component_count_id + '">');

    $("#" + box_component_count_id).css("height","3vh")



    //////////
    if (data.description) {
        var label_component_id2 = "label_component_dec2"
        $("#interact_ui").append('<div class ="label_component" id="'+ label_component_id2 +'"></div>');
        var labelLeft = data.description.labelLeft
        var labelRight = ""
    
        $("#" + label_component_id2).append('<div class ="label_left" id="' + label_component_id2 + '_label_left' + '">' + labelLeft + '</div>');
        $("#" + label_component_id2).append('<div class ="label_right" id="' + label_component_id2 + '_label_right' + '">' + labelRight + '</div>');
    
        var box_component_id2 = "box_component_description2"
        $("#interact_ui").append('<div class ="box_component transparent" id="' + box_component_id2 + '">');
    
        $("#" + box_component_id2).css("height","11vh")
        $("#" + box_component_id2).css("overflow","auto")
    
    
        $.each(data.description.items, function (index, item) {
            var img_box_id3 = "img_box3_" + index 
            $("#box_component_description2").append('<div class ="img_box transparent" id="' + img_box_id3 + '">')
            var img_url2 = 'url("items/' + item.name + '.png")'
            $("#" + img_box_id3).css("background-image",img_url2)
            $("#" + img_box_id3).css("height","5vh")
            $("#" + img_box_id3).css("width","5vh")
            $("#" + img_box_id3).append('<div class ="label_item_count">x' + item.count + '</div>')  
        })
    }
    ////////






    CurrentProp = data.PropId      
}

$(function(){
    window.addEventListener("message", function(event){


        if (event.data.loading) {
            if (event.data.loading == "show") {
                $(".loading").fadeIn(500);

                if (event.data.message) {
                    $(".loading_text").html(event.data.message)
                } 
            }else{
                $(".loading").fadeOut(500);
            }
            return;
        }




        if (event.data.display == true){
            if (event.data.type == "Code") {
                $("#interact_ui").hide();
                $("#doorlock").show();
                $("#doorlock_code").html("");

                codeText = ""
                codeNumber = ""

                CurrentSituation = event.data.action 
                CurrentProp = event.data.PropId
                adv = event.data.adv    
            }else if (event.data.type == "Management"){
                CurrentSituation = event.data.action 
                $("#interact_ui").show();
                $("#doorlock").hide();
                OpenStorage(event.data)
            }else if (event.data.type == "Interact"){
                CurrentSituation = event.data.action 
                $("#interact_ui").show();
                $("#doorlock").hide();
                OpenInteract(event.data)
            }

            $(".ui").fadeIn(100);
        }else{
            $(".ui").fadeOut(100);
        }
    })
})

$(document).ready(function(){

    $(".ui").hide();
    $(".loading").hide();

    $(".doorlock_buttons").click(function() {
        var char = $(this).html()
        codeText = codeText + "*"
        codeNumber = "" + codeNumber + char + ""
        
        $('#doorlock_code').html(codeText)

        if (codeText.length > 3) {
            $.post(`https://${GetParentResourceName()}/number`, JSON.stringify({id: CurrentProp, adv: adv, number:  codeNumber,situation: CurrentSituation}));
        }
    });

    $(".doorlock_buttons2").click(function() {
        codeText = ""
        codeNumber = ""
        $('#doorlock_code').html(codeText)
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
            return;
        }

        if (CurrentSituation == "SetCode" || CurrentSituation == "OpenCode") {

            const match = keyMappings.find(mapping => mapping.keyCode === data.which);
            if (match) {
                var char = match.key
                codeText = codeText + "*"
                codeNumber = "" + codeNumber + char + ""
                
                $('#doorlock_code').html(codeText)
        
                if (codeText.length > 3) {
                    $.post(`https://${GetParentResourceName()}/number`, JSON.stringify({id: CurrentProp, adv: adv, number:  codeNumber,situation: CurrentSituation}));
                }
            } 

            
        }else{
            return;
        }
    };

});