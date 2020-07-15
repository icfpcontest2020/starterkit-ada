with Text_IO;
with Ada.Command_Line;
with AWS.Client;
with AWS.Headers;
with AWS.Response;
with AWS.Messages;

procedure main is
  hdrs : AWS.Headers.List := AWS.Headers.Empty_List;
  server_url : constant String := Ada.Command_Line.Argument(1);
  player_key : constant String := Ada.Command_Line.Argument(2);
  result : AWS.Response.Data;
  status : AWS.Messages.Status_Code;
begin
  Text_IO.Put_Line("ServerURL: " & server_url & ", PlayerKey: " & player_key);

  AWS.Headers.Add(hdrs, "Content-Type", "text/plain");
  result := AWS.Client.Post(URL => server_url, Data => player_key, Headers => hdrs);
  status := AWS.Response.Status_Code(result);
  if AWS.Messages.Image(status) = "200" then
    Text_IO.Put_Line("Server response: " & AWS.Response.Message_Body(result));
  else
    Text_IO.Put_Line("Unexpected server response:");
    Text_IO.Put_Line("HTTP code: " & AWS.Messages.Image(status));
    Text_IO.Put_Line("Response body: " & AWS.Response.Message_Body(result));
    Ada.Command_Line.Set_Exit_Status(2);
  end if;
end main;
