defmodule Data.Contexts.MemberContext do
  @moduledoc false

  alias Ecto.Changeset
  import Ecto.Query

  alias Data.{
    Repo,
    Schemas.Member,
    Schemas.MemberPlan,
    Schemas.MemberPhone,
    Schemas.MemberSkippingHierarchy,
    Schemas.Account
  }

  def validate_params(:search, params) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:page_number, :display_per_page, :sort_by, :order_by], message: "is required")
    |> lower_value(:sort_by)
    |> lower_value(:order_by)
    |> Changeset.validate_inclusion(:sort_by, [
      "member_id",
      "first_name",
      "card_no",
      "status",
      "account"
    ], message: "invalid parameters")
    |> Changeset.validate_inclusion(:order_by, [
      "asc",
      "desc"
    ], message: "invalid parameters")
    |> is_valid_changeset?()
  end

  def validate_params(:view, params) do
    fields = %{
      member_id: :string,
      tab: :string,
      plan: :map,
      dependent: :map,
      actual_utilization: :map,
      ibnr: :map
    }

    {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([:member_id], message: "is required")
      |> is_valid_tab()
      |> is_valid_changeset?()
  end

  def is_valid_tab(changeset) do
    tab = if Map.has_key?(changeset.changes, :tab), do: changeset.changes.tab, else: ""
    case tab do
      "profile" -> changeset
      "dependent" -> changeset
      "utilization" -> changeset
      "plan" -> changeset
      "" -> changeset
      _ ->
        Changeset.add_error(changeset, :tab, "is Invalid.")
    end
  end

  def is_valid_changeset?(changeset), do: {changeset.valid?, changeset}

  def get_members({:error, changeset}), do: {:error, changeset}

  def get_members(params) do
    search_value = if Map.has_key?(params, :search_value), do: params.search_value, else: ""
    offset = (params.page_number * params.display_per_page) - params.display_per_page

    Member
    |> select_datatable()
    |> order_datatable(
      params.sort_by,
      params.order_by
    )
    |> offset(^offset)
    |> limit(^params.display_per_page)
    |> Repo.all()
    |> preload_account()
    |> Enum.filter(fn(x) ->
      String.contains?(downcase(x.member_id), downcase(search_value)) or
      String.contains?(downcase(Enum.join([x.first_name, x.middle_name, x.last_name, x.suffix], " ")), downcase(search_value)) or
      String.contains?((if is_nil(downcase(x.card_no)), do: ""), downcase(search_value)) or
      String.contains?(downcase(x.account_name), downcase(search_value)) or
      String.contains?(downcase(x.status), downcase(search_value))
    end)
    |> return_value
  end

  defp select_datatable(query) do
    query
    |> select([m],
              %{
                member_id: m.member_id,
                first_name: m.first_name,
                middle_name: m.middle_name,
                last_name: m.last_name,
                suffix: m.suffix,
                card_no: m.card_no,
                account_code: m.account_code,
                status: m.status
              }
    )
  end

  def get_member({:error, changeset}, _), do: {:error, changeset}
  def get_member(params, "") do
    params
    |> get_member()
    |> add_profile(get_member_profile(params))
    |> add_plan(get_member_plans(params))
    |> add_dependent(get_member_dependents(params))
    |> add_utilization(get_member_utilizations(params))
  end
  def get_member(params, tab) when tab == "profile" do
    params
    |> get_member()
    |> add_profile(get_member_profile(params))
  end
  def get_member(params, tab) when tab == "plan" do
    params
    |> get_member()
    |> add_plan(get_member_plans(params))
  end
  def get_member(params, tab) when tab == "dependent" do
    params
    |> get_member()
    |> add_dependent(get_member_dependents(params))
  end
  def get_member(params, tab) when tab == "utilization" do
    params
    |> get_member()
    |> add_utilization(get_member_utilizations(params))
  end

  defp add_profile(nil, []), do: nil
  defp add_profile(changeset, []), do: changeset |> Map.put(:profile, [])
  defp add_profile(changeset, params) do
    changeset
    |> Map.put(:profile, params)
  end

  defp add_plan(nil, []), do: nil
  defp add_plan(changeset, []), do: changeset |> Map.put(:plan, [])
  defp add_plan(changeset, params) do
    changeset
    |> Map.put(:plan, params)
  end

  defp add_dependent(nil, []), do: nil
  defp add_dependent(changeset, []), do: changeset |> Map.put(:dependent, [])
  defp add_dependent(changeset, params) do
    changeset
    |> Map.put(:dependent, params)
  end

  defp add_utilization(nil, []), do: nil
  defp add_utilization(changeset, []), do: changeset |> Map.put(:utilization, [])
  defp add_utilization(changeset, params) do
    changeset
    |> Map.put(:utilization, params)
  end

  def get_member(params) do
    Member
    |> where([m], m.member_id == ^params.member_id)
    |> select([m],
              %{
                first_name: m.first_name,
              middle_name: m.middle_name,
              last_name: m.last_name,
              suffix: m.suffix,
              birth_date: m.birth_date,
              member_type: m.member_type,
              effective_date: m.effective_date,
              expiry_date: m.expiry_date,
              account_code: m.account_code
              }
    )
    |> Repo.one()
  end

  def get_member_profile(params) do
    Member
    |> where([m], m.member_id == ^params.member_id)
    |> select([m],
              %{
                gender: m.gender,
                civil_status: m.civil_status,
                card_no: m.card_no,
                effective_date: m.effective_date,
                employee_no: m.employee_no,
                hired_date: m.hired_date,
                regularization_date: m.regularization_date,
                tin: m.tin,
                philhealth: m.philhealth,
                philhealth_no: m.philhealth_no,
                is_senior_citizen: m.is_senior_citizen,
                senior_id_no: m.senior_id_no,
                is_pwd: m.is_pwd,
                pwd_id_no: m.pwd_id_no
              }
    )
    |> limit(1)
    |> Repo.one()
    |> preload_member_details(params)
  end

  defp preload_member_details(nil, _params), do: []
  defp preload_member_details(changeset, params) do
    changeset
    |> Map.put(:member_phones, preload_member_phone(params.member_id))
    |> Map.put(:member_skipping_hierarchy, preload_member_skipping_hierarchy(params.member_id))
  end

  def get_member_utilizations(_params) do
    []
  end

  def get_member_plans(params) do
    search_value = if Map.has_key?(params, :plan), do: params.plan["search_value"], else: ""
    offset = (params.plan["page_number"] * params.plan["display_per_page"]) - params.plan["display_per_page"]

    MemberPlan
    |> where([mp],
             mp.member_id == ^params.member_id and
             (ilike(mp.tier, ^"%#{search_value}%") or
              ilike(mp.name,  ^"%#{search_value}%") or
             ilike(fragment("CAST(? AS TEXT)", mp.no_of_benefits), ^"%#{search_value}%") or
              ilike(mp.limit_type, ^"%#{search_value}%") or
             ilike(fragment("CAST(? AS TEXT)", mp.limit_amount), ^"%#{search_value}%")
             )
    )
    |> select([mp], mp)
    |> order_datatable(
      params.plan["sort_by"],
      params.plan["order_by"]
    )
    |> offset(^offset)
    |> limit(^params.plan["display_per_page"])
    |> Repo.all()
  end

  def get_member_dependents(params) do
    search_value = if Map.has_key?(params, :dependent), do: params.dependent["search_value"], else: ""
    offset = (params.dependent["page_number"] * params.dependent["display_per_page"]) - params.dependent["display_per_page"]

    Member
    |> where([m],
             m.principal_member_id == ^params.member_id and
             (ilike(m.member_id, fragment("REPLACE(?, '_', '\\_')", ^"#{search_value}%")) or
              ilike(fragment("CONCAT(?, ' ', ?, ' ', ?, ' ', ?)",
                    m.first_name, m.middle_name, m.last_name, m.suffix),
                    ^"%#{search_value}%") or
              ilike(m.card_no, fragment("REPLACE(?, '_', '\\_')", ^"#{search_value}%")))
    )
    |> select([m],
              %{
                member_id: m.member_id,
                first_name: m.first_name,
                last_name: m.last_name,
                middle_name: m.middle_name,
                suffix: m.suffix,
                card_no: m.card_no
              }
    )
    |> order_datatable(
      params.dependent["sort_by"],
      params.dependent["order_by"]
    )
    |> offset(^offset)
    |> limit(^params.dependent["display_per_page"])
    |> Repo.all()
  end

  #Ascending
  defp order_datatable(query, nil, nil), do: query
  defp order_datatable(query, "", ""), do: query
  defp order_datatable(query, "card_no", "asc"), do: query |> order_by([m], asc: m.card_no)
  defp order_datatable(query, "name", "asc"), do: query |> order_by([m], asc: m.name)
  defp order_datatable(query, "tier", "asc"), do: query |> order_by([m], asc: m.tier)
  defp order_datatable(query, "code", "asc"), do: query |> order_by([m], asc: m.code)
  defp order_datatable(query, "member_id", "asc"), do: query |> order_by([m], asc: m.member_id)
  defp order_datatable(query, "coverage", "asc"), do: query |> order_by([m], asc: m.coverage)
  defp order_datatable(query, "account", "asc"), do: query |> order_by([m], asc: m.account)

  #Descending
  defp order_datatable(query, "card_no", "desc"), do: query |> order_by([m], desc: m.card_no)
  defp order_datatable(query, "name", "desc"), do: query |> order_by([m], desc: m.name)
  defp order_datatable(query, "tier", "desc"), do: query |> order_by([m], desc: m.tier)
  defp order_datatable(query, "code", "desc"), do: query |> order_by([m], desc: m.code)
  defp order_datatable(query, "member_id", "desc"), do: query |> order_by([m], desc: m.member_id)
  defp order_datatable(query, "coverage", "desc"), do: query |> order_by([m], desc: m.coverage)
  defp order_datatable(query, "account", "desc"), do: query |> order_by([m], desc: m.account)

  defp return_value(member) do
    %{total_number: Enum.count(member), members: member}
  end

  defp downcase(nil), do: nil
  defp downcase(value), do: String.downcase(value)

  defp preload_account(members) do
    for m <- members do
      account =
        Account
        |> select([a], %{name: a.name})
        |> where([a], a.code == ^m.account_code)
        |> Repo.one()

      m
      |> Map.put(:account_name, account.name)
    end
  end

  defp preload_member_phone(member_id) do
    MemberPhone
    |> select([m],
              %{type: m.type,
                country_code: m.country_code,
                area_code: m.area_code,
                number: m.number,
                local: m.local})
    |> where([m], m.member_id == ^member_id)
    |> Repo.all()
  end

  defp preload_member_skipping_hierarchy(member_id) do
    MemberSkippingHierarchy
    |> select([m],
              %{relationship: m.relationship,
                first_name: m.first_name,
                last_name: m.last_name,
                middle_name: m.middle_name,
                suffix: m.suffix,
                birth_date: m.birth_date,
                reason: m.reason,
                supporting_docs: m.supporting_docs})
    |> where([m], m.member_id == ^member_id)
    |> Repo.all()
  end

  defp lower_value(changeset, key) do
    with true <- Map.has_key?(changeset.changes, key) do
      string =
        changeset.changes[key]
        |> String.split(" ")
        |> Enum.map(&(String.downcase(&1)))
        |> Enum.join(" ")
      changeset
      |> Changeset.put_change(key, string)
    else
      _ ->
        changeset
    end
  end

  # For seed

 def insert_member_seed(params) do
    params
    |> member_get_by()
    |> create_update_member(params)
  end

  defp create_update_member(nil, params) do
    %Member{}
    |> Member.changeset(params)
    |> Repo.insert()
  end

  defp create_update_member(member, params) do
    member
    |> Member.changeset(params)
    |> Repo.update()
  end

  defp member_get_by(params) do
    Member |> Repo.get_by(params)
  end
end
