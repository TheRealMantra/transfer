$(function () {
  let frameitemStatus;
  let selectedItems;
  let key;
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
      case "openitemsell":
        selectedItems = [];
        frameitemStatus = {};
        $(".selectallbutton").toggleClass("selected", false);
        showMainPage("home-page");
        $(".container").fadeIn();
        break;
      case "updateProductList":
        $("#fitemlist").empty();
        $("#fitemlist").append(event.data.products);
        $("#itemstocklist").empty();
        $("#itemstocklist").append(event.data.products2);
        $("#sitext").text(event.data.label);
        key = event.data.key;
        break;
      case "updateCMDList":
        $("#fcommanditemlist").empty();
        $("#fcommanditemlist").append(event.data.products);
        $("#commandpage").fadeIn();
        break;
    }
  });

  $("#itemlist").on("click", "#frameitem", function () {
    let checkbox = $(this).find("#checkbox");
    let img = $(this).find("#checkbox img");
    const frameitemId = $(this).attr("number");
    const itemName = $(this).attr("itemlabel");
    const itemAmount = $(this).attr("max");
    if (frameitemStatus[frameitemId]) {
      checkbox.css("background-color", "rgba(46, 46, 46, 0.50)");
      img.attr("src", "imgs/checkoff.png");
      frameitemStatus[frameitemId] = false;
      for (let i = 0; i < selectedItems.length; i++) {
        if (selectedItems[i][1] == itemName) {
          selectedItems.splice(i, 1);
          break;
        }
      }
    } else {
      checkbox.css("background-color", "#A258FF");
      img.attr("src", "imgs/checkon.png");
      frameitemStatus[frameitemId] = true;
      if (itemAmount > 0) {
        selectedItems.push([
          itemName + " (x" + itemAmount + ")",
          itemName,
          itemAmount,
          frameitemId,
        ]);
      }
    }
    sound();
  });
  $(".selectallbutton").click(function () {
    const frameItems = $("#itemlist #frameitem");
    const selectAllCheckbox = $(this).hasClass("selected");
    $("#selectedlist").empty();
    selectedItems = [];
    frameItems.each(function () {
      let checkbox = $(this).find("#checkbox");
      let img = $(this).find("#checkbox img");
      const frameitemId = $(this).attr("number");
      const itemName = $(this).attr("itemlabel");
      const itemAmount = $(this).attr("max");
      const itemNumber = $(this).attr("number");
      if (selectAllCheckbox) {
        checkbox.css("background-color", "rgba(46, 46, 46, 0.50)");
        img.attr("src", "imgs/checkoff.png");
        frameitemStatus[frameitemId] = false;
      } else {
        checkbox.css("background-color", "#A258FF");
        img.attr("src", "imgs/checkon.png");
        frameitemStatus[frameitemId] = true;
        if (itemAmount > 0) {
          selectedItems.push([
            itemName + " (x" + itemAmount + ")",
            itemName,
            itemAmount,
            itemNumber,
          ]);
        }
      }
    });
    sound();
    $(this).toggleClass("selected", !selectAllCheckbox);
  });

  $("#home-pagebutton").click(function () {
    showMainPage("home-page");
    sound2();
  });

  $("#sell-pagebutton").click(function () {
    showMainPage("sell-page");
    sound2();
  });

  $("#stock-pagebutton").click(function () {
    showMainPage("stock-page");
    sound2();
  });
  $("#viewbutton").click(function () {
    showMainPage("stock-page");
    sound2();
  });
  $("#selectedlist").on("click", "p #arrowUp", function () {
    const parentElement = $(this).parent();
    const itemName = $(this).parent().data("itemname");
    const itemAmount = parseInt($(this).parent().data("itemamount"));
    const stepAmount = parseInt($(this).parent().find("#amountInput").val());
    const maxAmount = parseInt($(this).parent().data("maxamount"));
    const itemNumber = parseInt($(this).parent().data("itemnumber"));
    if (itemAmount + stepAmount <= maxAmount) {
      const newAmount = itemAmount + stepAmount;
      parentElement.html(
        itemName +
          " (x" +
          newAmount +
          ")<input type='number' id='amountInput' value='" +
          stepAmount +
          "'><img id='arrowUp' src='imgs/arrowup.svg'><img id='arrowDown' src='imgs/arrowdown.svg'>"
      );
      parentElement.data("itemamount", newAmount);
      const frameItems = $("#itemlist #frameitem");
      frameItems.filter(`[number='${itemNumber}']`).attr("amount", newAmount);
      selectedItems.find((item) => item[1] == itemName)[2] = newAmount;
      calculateTotalPrice();
    }
    sound();
  });
  $("#selectedlist").on("click", "p #arrowDown", function () {
    const parentElement = $(this).parent();
    const itemName = $(this).parent().data("itemname");
    const itemAmount = parseInt($(this).parent().data("itemamount"));
    const stepAmount = parseInt($(this).parent().find("#amountInput").val());
    const itemNumber = parseInt($(this).parent().data("itemnumber"));
    if (itemAmount - stepAmount >= 0) {
      const newAmount = itemAmount - stepAmount;
      parentElement.html(
        itemName +
          " (x" +
          newAmount +
          ")<input type='number' id='amountInput' value='" +
          stepAmount +
          "'><img id='arrowUp' src='imgs/arrowup.svg'><img id='arrowDown' src='imgs/arrowdown.svg'>"
      );
      parentElement.data("itemamount", newAmount);
      const frameItems = $("#itemlist #frameitem");
      frameItems.filter(`[number='${itemNumber}']`).attr("amount", newAmount);
      selectedItems.find((item) => item[1] == itemName)[2] = newAmount;
      calculateTotalPrice();
    }
    sound();
  });
  $(".sellbutton").click(function () {
    let selectedListHtml = "";
    for (let i = 0; i < selectedItems.length; i++) {
      selectedListHtml +=
        "<p data-itemname='" +
        selectedItems[i][1] +
        "' data-itemamount='" +
        selectedItems[i][2] +
        "' data-maxamount='" +
        selectedItems[i][2] +
        "' data-itemnumber='" +
        selectedItems[i][3] +
        "'>" +
        selectedItems[i][0] +
        "<input type='number' id='amountInput' value='1'><img id='arrowUp' src='imgs/arrowup.svg'><img id='arrowDown' src='imgs/arrowdown.svg'></p>";
    }
    $("#selectedlist").html(selectedListHtml);
    calculateTotalPrice();
    sound();
    $("#submitpage").show();
  });
  $("#submitbutton").click(function () {
    const selectAllCheckbox = $(".selectallbutton").hasClass("selected");
    $(".container").fadeOut();
    $.post(`https://${GetParentResourceName()}/escape`, JSON.stringify({}));
    $.post(
      `https://${GetParentResourceName()}/sellitem`,
      JSON.stringify({
        selectedItems: selectedItems,
        key: key,
        isSellAll: selectAllCheckbox,
      })
    );
    sound();
    $("#submitpage").hide();
  });
  $("#exitbutton").click(function () {
    sound();
    $(".container").fadeOut();
    $.post(`https://${GetParentResourceName()}/escape`, JSON.stringify({}));
  });
  function calculateTotalPrice() {
    let totalPrice = 0;
    const frameItems = $("#itemlist #frameitem");
    frameItems.each(function () {
      const frameitemId = $(this).attr("number");
      if (frameitemStatus[frameitemId]) {
        const price = parseInt($(this).attr("price") * $(this).attr("amount"));
        totalPrice += price;
      }
    });
    $("#totalprice span").text(totalPrice + "$");
  }
  function showMainPage(pageClass) {
    $("#submitpage").hide();
    $(".mainpage").hide();
    $("." + pageClass).show();
    $("#mainmenu div").removeClass("selected-class");
    $("#mainmenu span").removeClass("selected-color");
    $("#" + pageClass + "button").addClass("selected-class");
    $("#" + pageClass + "button span").addClass("selected-color");
  }
  $(document).on("click", function (event) {
    const target = $(event.target);
    const submitPage = $("#submitpage");
    if (
      !target.closest(submitPage).length &&
      target.attr("id") != "arrowUp" &&
      target.attr("id") != "arrowDown" &&
      !target.hasClass("sellbutton") &&
      submitPage.is(":visible")
    ) {
      submitPage.hide();
      $(".selectallbutton").click();
    }
  });
  window.addEventListener("keyup", function (data) {
    if (data.key == "Escape") {
      $(".container").fadeOut();
      $("#commandpage").fadeOut();
      $.post(`https://${GetParentResourceName()}/escape`, JSON.stringify({}));
    }
  });
  function sound() {
    document.getElementById("sound").pause();
    document.getElementById("sound").currentTime = 0;
    document.getElementById("sound").volume = 0.3;
    document.getElementById("sound").play();
  }
  function sound2() {
    document.getElementById("sound2").pause();
    document.getElementById("sound2").currentTime = 0;
    document.getElementById("sound2").volume = 0.3;
    document.getElementById("sound2").play();
  }
});
