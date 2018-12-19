defmodule Data.Factory do
  @moduledoc "All mock data used for testing are defined here"
  use ExMachina.Ecto, repo: Data.Repo

  alias Data.Schemas.{
    Clinic,
    Member,
    MemberPhone,
    MemberSkippingHierarchy,
    MemberPlan,
    Plan,
    Account
  }

  def clinic_factory do
    %Clinic{}
  end

  def members_factory do
    %Member{}
  end

  def member_phones_factory do
    %MemberPhone{}
  end

  def member_skipping_hierarchy_factory do
    %MemberSkippingHierarchy{}
  end

  def member_plans_factory do
    %MemberPlan{}
  end

  def plans_factory do
    %Plan{}
  end

  def accounts_factory do
    %Account{}
  end
end
