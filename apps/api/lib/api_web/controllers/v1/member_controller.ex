defmodule ApiWeb.V1.MemberController do
  use ApiWeb, :controller

  alias Data.{
    Contexts.MemberContext,
    Contexts.ValidationContext,
    Contexts.UtilityContext
  }

  alias ApiWeb.Views.{
    MemberView
  }

  def get_member(conn, params) do
      :view
      |> MemberContext.validate_params(params)
      |> ValidationContext.valid_changeset()
      |> MemberContext.get_member(params["tab"])
      |> return_result("member.json", params["tab"], conn)
  end

  def get_members(conn, params) do
     :search
     |> MemberContext.validate_params(params)
     |> ValidationContext.valid_changeset()
     |> MemberContext.get_members()
     |> return_result("get_members.json", "", conn)
  end

  defp return_result({:error, changeset}, _, _, conn) do
    conn
    |> put_status(400)
    |> put_view(MemberView)
    |> render("error.json", error: UtilityContext.transform_error_message(changeset))
  end

  defp return_result([], _, _json_name, conn) do
    conn
    |> put_status(400)
    |> put_view(MemberView)
    |> render("error.json", error: "No member matched your search")
  end

  defp return_result(nil, _, _json_name, conn) do
    conn
    |> put_status(400)
    |> put_view(MemberView)
    |> render("error.json", error: "No member matched your search")
  end

  defp return_result(result, json_name, tab, conn) do
    case tab do
      "" ->
        conn
        |> put_status(200)
        |> put_view(MemberView)
        |> render(json_name, result: result)
      "profile" ->
        conn
        |> put_status(200)
        |> put_view(MemberView)
        |> render("profile_" <> json_name, result: result)
      "plan" ->
        conn
        |> put_status(200)
        |> put_view(MemberView)
        |> render("plan_" <> json_name, result: result)
      "dependent" ->
        conn
        |> put_status(200)
        |> put_view(MemberView)
        |> render("dependent_" <> json_name, result: result)
      "utilization" ->
        conn
        |> put_status(200)
        |> put_view(MemberView)
        |> render("utilization_" <> json_name, result: result)
  end
  end
end
