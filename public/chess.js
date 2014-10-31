$("#chessboard tr td").click(function()
{
  square = this.id;

  if ( $("#"+square).hasClass("selected") )
  {
    $("#initial_position").val("");
    $("#"+square).removeClass("selected")
  }

  else if ( $("#initial_position").val().length === 0 )
  {
    $("#initial_position").val(square);
    $("#"+square).addClass("selected");
  }

  else if ( $("#new_position").val().length === 0 )
  {
    $("#new_position").val(square);
    if (( $("#initial_position").val().length != 0 )
        && ( $("#new_position").val().length != 0 ))
    {
      $("#move_button").trigger("click");
    }
  }

});
