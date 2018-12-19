defmodule ApiWeb.Views.MemberView do

  use ApiWeb, :view

  def render("error.json", %{error: error}) do
    %{
      errors: error
    }
  end

  def render("get_members.json", %{result: member}) do
    %{
      total_number: member.total_number,
      members: render_many(
            member.members,
            ApiWeb.Views.MemberView,
            "members.json",
            as: :result)
    }
  end

  def render("members.json", %{result: member}) do
    %{
      member_id: member.member_id,
      member_name: Enum.join([member.first_name, member.middle_name, member.last_name, member.suffix], " "),
      account: member.account_name,
      card_no: member.card_no,
      status: member.status
    }
  end

  def render("member.json", %{result: member}) do
    %{
      account_code: member.account_code,
      member_type: member.member_type,
      effective_date: member.effective_date,
      expiry_date: member.expiry_date,
      birth_date: member.birth_date,
      first_name: member.first_name,
      middle_name: member.middle_name,
      last_name: member.last_name,
      suffix: member.suffix,
      profile: member.profile,
      plan: render_many(
            member.plan,
            ApiWeb.Views.MemberView,
            "view_member_plan.json",
            as: :result),
      dependent: render_many(
            member.dependent,
            ApiWeb.Views.MemberView,
            "view_member_dependent.json",
            as: :result),
      utilization: render_many(
            member.utilization,
            ApiWeb.Views.MemberView,
            "view_member_utilization.json",
            as: :result)
    }
  end

  def render("profile_member.json", %{result: member}) do
    %{
      account_code: member.account_code,
      member_type: member.member_type,
      effective_date: member.effective_date,
      expiry_date: member.expiry_date,
      birth_date: member.birth_date,
      first_name: member.first_name,
      middle_name: member.middle_name,
      last_name: member.last_name,
      suffix: member.suffix,
      profile: member.profile
    }
  end

  def render("plan_member.json", %{result: member}) do
    %{
      account_code: member.account_code,
      member_type: member.member_type,
      effective_date: member.effective_date,
      expiry_date: member.expiry_date,
      birth_date: member.birth_date,
      first_name: member.first_name,
      middle_name: member.middle_name,
      last_name: member.last_name,
      suffix: member.suffix,
      plan: render_many(
            member.plan,
            ApiWeb.Views.MemberView,
            "view_member_plan.json",
            as: :result)
    }
  end

  def render("dependent_member.json", %{result: member}) do
    %{
      account_code: member.account_code,
      member_type: member.member_type,
      effective_date: member.effective_date,
      expiry_date: member.expiry_date,
      birth_date: member.birth_date,
      first_name: member.first_name,
      middle_name: member.middle_name,
      last_name: member.last_name,
      suffix: member.suffix,
      dependent: render_many(
            member.dependent,
            ApiWeb.Views.MemberView,
            "view_member_dependent.json",
            as: :result)
    }
  end

  def render("utilization_member.json", %{result: member}) do
    %{
      account_code: member.account_code,
      member_type: member.member_type,
      effective_date: member.effective_date,
      expiry_date: member.expiry_date,
      birth_date: member.birth_date,
      first_name: member.first_name,
      middle_name: member.middle_name,
      last_name: member.last_name,
      suffix: member.suffix,
      utilization: render_many(
            member.utilization,
            ApiWeb.Views.MemberView,
            "view_member_utilization.json",
            as: :result)
    }
  end

  def render("view_member_utilization.json", %{result: utilization}) do
    %{}
  end

  def render("view_member_dependent.json", %{result: dependent}) do
    %{
      member_id: dependent.member_id,
      first_name: dependent.first_name,
      last_name: dependent.last_name,
      middle_name: dependent.middle_name,
      suffix: dependent.suffix,
      card_no: dependent.card_no
    }
  end

  def render("view_member_plan.json", %{result: plan}) do
    %{
      plan_tier: plan.tier,
      plan_code: plan.plan_code,
      plan_name: plan.name,
      no_of_benefits: plan.no_of_benefits,
      limit_type: plan.limit_type,
      limit_amount: plan.limit_amount
    }
  end

  def render("member_skipping_hierarchy.json", %{member_skipping_hierarchy: member}) do
    %{
      relationship: member.relationship,
      first_name: member.first_name,
      middle_name: member.middle_name,
      last_name: member.last_name,
      suffix: member.suffix,
      reason: member.reason
    }
  end

  def render("member_phones.json", %{member_phones: member}) do
    %{
      type: member.type,
      country_code: member.country_code,
      area_code: member.area_code,
      number: member.number,
      local: member.local
    }
  end
end
