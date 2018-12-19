defmodule ApiWeb.MemberControllerTest do
  use ApiWeb.ConnCase

  describe "view_member_profile" do
    test "with valid params" do
      # package1 = insert(:package, code: "PCODE01", name: "Test1")
      member = insert(:members,
                      step: "5",
                      status: "Active",
                      version: "1",
                      member_id: "MEMBER123",
                      card_no: "CARD123",
                      policy_no: "PLCY123",
                      first_name: "First",
                      middle_name: "Middle",
                      last_name: "Last",
                      suffix: "Jr.",
                      plan_codes: ["PLAN_01", "PLAN_02"]
      )
      member2 = insert(:members,
                      step: "5",
                      status: "Active",
                      version: "1",
                      member_id: "MEMBER_012",
                      principal_member_id: "MEMBER123",
                      card_no: "CARD999",
                      policy_no: "PLCY123",
                      first_name: "Test",
                      middle_name: "2",
                      last_name: "wewww",
                      suffix: ""
      )
      member1 = insert(:members,
                      step: "5",
                      status: "Active",
                      version: "1",
                      member_id: "MEMBER0122",
                      principal_member_id: "MEMBER123",
                      card_no: "CARD123",
                      policy_no: "PLCY123",
                      first_name: "Test",
                      middle_name: "1",
                      last_name: "tessst",
                      suffix: "Jr.",
                      plan_codes: ["PLAN_01", "PLAN_02"]
      )
     insert(:member_skipping_hierarchy,
                         member_id: member.member_id,
                         relationship: "none",
                         first_name: "Juan",
                         last_name: "rosario",
                         middle_name: "del",
                         suffix: "Jr.",
                         reason: "none",
                         gender: "male"
      )
     insert(:member_skipping_hierarchy,
                         member_id: member1.member_id,
                         relationship: "none",
                         first_name: "Mary",
                         last_name: "Magdalene",
                         middle_name: "",
                         suffix: "",
                         reason: "none",
                         gender: "female"
      )
     insert(:member_skipping_hierarchy,
                         member_id: member2.member_id,
                         relationship: "none",
                         first_name: "Mary",
                         last_name: "Magdalene",
                         middle_name: "",
                         suffix: "",
                         reason: "none",
                         gender: "female"
      )
      insert(:member_phones,
                     member_id: member.member_id,
                     type: "PCODE03",
                     country_code: "03",
                     area_code: "550",
                     number: "47444",
                     local: "22222")
      insert(:member_phones,
                     member_id: member1.member_id,
                     type: "PCODE02",
                     country_code: "02",
                     area_code: "880",
                     number: "87000",
                     local: "12345")
      insert(:member_phones,
                     member_id: member2.member_id,
                     type: "PCODE02",
                     country_code: "02",
                     area_code: "880",
                     number: "87000",
                     local: "12345")
       plan = insert(:plans,
                     code: "123",
                     name: "test",
                     limit_type: "none")
      insert(:member_plans,
             member_id: member.member_id,
             code: "MP_123",
             plan_code: plan.code,
             tier: "1",
             name: plan.name,
             no_of_benefits: plan.no_of_benefits,
             limit_type: plan.limit_type,
             limit_amount: plan.limit_amount)
      conn = post(build_conn(), "api/v1/members/get_member",
                             %{
                               member_id: "MEMBER123",
                               tab: "",
                               plan: %{
                                 search_value: "test",
                                 page_number: 1,
                                 display_per_page: 5,
                                 sort_by: "code",
                                 order_by: "asc"
                               },
                               dependent: %{
                                 search_value: "CARD",
                                 page_number: 1,
                                 display_per_page: 5,
                                 sort_by: "member_id",
                                 order_by: "asc"
                               },
                               actual_utilization: %{
                                 search_value: "Inpatient",
                                 page_number: 1,
                                 display_per_page: 5,
                                 sort_by: "coverage",
                                 order_by: "asc"
                               },
                               ibnr: %{
                                 search_value: "Outpatient",
                                 page_number: 1,
                                 display_per_page: 5,
                                 sort_by: "coverage",
                                 order_by: "asc"
                              }
                             })
      assert json_response(conn, 200)
    end

    test "with invalid params/400" do
      insert(
        :members,
        step: "5",
        status: "Active",
        version: "1",
        member_id: "MEMBER123",
        card_no: "CARD123",
        policy_no: "PLCY123",
        first_name: "First",
        middle_name: "Middle",
        last_name: "Last",
        suffix: "Jr."
      )
      conn = post(build_conn(), "api/v1/members/get_member",
                             %{
                               member_id: "123",
                               tab: "ibnr",
                               dependent: %{
                                 search_value: "Mary Dela Cruz",
                                 page_number: "1",
                                 display_per_page: "5",
                                 sort_by: "member_id",
                                 order_by: "asc"
                               }
                             })
      assert json_response(conn, 400)
    end
  end

  describe "test get_members" do
    test "with valid params/200" do
      ac = insert(
        :accounts,
        code: "ACCT011",
        status: "Active",
        name: "Jollibee"
      )
      insert(
        :members,
        status: "Active",
        account_code: ac.code,
        member_id: "test1",
        card_no: "1234",
        policy_no: "PLCY123",
        first_name: "Test2",
        middle_name: "Middle",
        last_name: "Last",
        suffix: "Jr."
      )
      insert(
        :members,
        status: "Active",
        card_no: "1234",
        account_code: ac.code,
        member_id: "test",
        policy_no: "PLCY123",
        first_name: "First",
        middle_name: "Middle",
        last_name: "Last",
        suffix: "Jr."
      )
      conn = post(build_conn(), "api/v1/members/get_members",
                             %{
                                 search_value: "j",
                                 page_number: "1",
                                 display_per_page: "5",
                                 sort_by: "member_id",
                                 order_by: "asc"
                             })
      assert json_response(conn, 200)
    end

    test "with invalid params/400" do
      ac = insert(
        :accounts,
        code: "ACCT011",
        status: "Active",
        name: "Jollibee"
      )
      insert(
        :members,
        status: "Active",
        account_code: ac.code,
        member_id: "test1",
        policy_no: "PLCY123",
        first_name: "Test2",
        middle_name: "Middle",
        last_name: "Last",
        suffix: "Jr."
      )
      insert(
        :members,
        status: "Active",
        account_code: ac.code,
        member_id: "test",
        policy_no: "PLCY123",
        first_name: "First",
        middle_name: "Middle",
        last_name: "Last",
        suffix: "Jr."
      )
      conn = post(build_conn(), "api/v1/members/get_members",
                             %{
                                 search_value: "test",
                                 page_number: "",
                                 display_per_page: "",
                                 sort_by: "",
                                 order_by: ""
                             })
      assert json_response(conn, 400)
    end
  end
end
