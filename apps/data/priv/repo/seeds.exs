alias Data.{
  Seeders.MemberSeeder,
  Seeders.AccountSeeder,
  Seeders.MemberPhoneSeeder,
  Seeders.MemberSkippingHierarchySeeder,
  Seeders.PlanSeeder,
  Seeders.MemberPlanSeeder,
}

  #Create RUV

  IO.puts "Seeding Account..."
  account_data =
    [
      %{
        #1
        code: "ACCT021",
        status: "Active",
        name: "Jollibee"
      },
      %{
        #2
        code: "ACCT911",
        status: "Active",
        name: "Mcdo"
      }
      ]
  [
    a1, a2
  ] = AccountSeeder.seed(account_data)

  #Create Member

  IO.puts "Seeding Member..."
  member_data =
    [
      %{
        #1
        step: "5",
        status: "Active",
        account_code: a1.code,
        member_id: "MEMBER_01",
        first_name: "Test2",
        middle_name: "Middle",
        last_name: "Last",
        suffix: "Jr.",
        plan_codes: ["PLAN_01", "PLAN_02"]
      },
      %{
        #2
        step: "5",
        status: "Active",
        account_code: a2.code,
        member_id: "MEMBER_02",
        first_name: "Test2",
        middle_name: "Middle",
        last_name: "Last",
        suffix: "Jr.",
        plan_codes: ["PLAN_01", "PLAN_02"]
      },
      %{
        #3
        step: "5",
        status: "Active",
        account_code: a2.code,
        member_id: "MEMBER_03",
        first_name: "Test3",
        middle_name: "Middle",
        last_name: "Last",
        suffix: "Jr.",
        plan_codes: ["PLAN_01", "PLAN_02"]
      }
      ]
  [
    m1, m2, m3
  ] = MemberSeeder.seed(member_data)

  #Create Member Phone

  IO.puts "Seeding Member phone..."
  member_phone_data =
    [
      %{
        #1
        member_id: m1.member_id,
        type: "PCODE03",
        country_code: "09",
        area_code: "550",
        number: "47444",
        local: "22222"
      },
      %{
        #2
        member_id: m2.member_id,
        type: "PCODE57",
        country_code: "09",
        area_code: "980",
        number: "47004",
        local: "22222"
      },
      %{
        #3
        member_id: m3.member_id,
        type: "PCODE99",
        country_code: "09",
        area_code: "002",
        number: "48888",
        local: "22222"
      }
      ]
  [
    mp1, mp2, mp3
  ] = MemberPhoneSeeder.seed(member_phone_data)

  #Create Member Phone

  IO.puts "Seeding Member skipping hierarchy..."
  member_skipping_data =
    [
      %{
        #1
        member_id: m1.member_id,
        relationship: "",
        first_name: "Mary",
        last_name: "Magdalene",
        middle_name: "",
        suffix: "",
        reason: "none",
        gender: "female"
      },
      %{
        #2
        member_id: m2.member_id,
        relationship: "none",
        first_name: "Juan",
        last_name: "rosario",
        middle_name: "del",
        suffix: "Jr.",
        reason: "none",
        gender: "male"
      },
      %{
        #3
        member_id: m3.member_id,
        relationship: "none",
        first_name: "Juan",
        last_name: "Pedro",
        middle_name: "",
        suffix: "Sr.",
        reason: "none",
        gender: "male"
      }
      ]
  [
    ms1, ms2, ms3
  ] = MemberSkippingHierarchySeeder.seed(member_skipping_data)

  #Create Plans

  IO.puts "Seeding plans..."
  plans_data =
    [
      %{
        #1
        code: "123",
        name: "test",
        limit_amount: "100",
        limit_amount: "100",
        limit_type: "none"
      }
      ]
  [
    p1
  ] = PlanSeeder.seed(plans_data)

  #Create Member Plans

  IO.puts "Seeding Member plans..."
  member_plans_data =
    [
      %{
        #1
        member_id: m1.member_id,
        code: "MP_123",
        plan_code: p1.code,
        tier: "1",
        name: p1.name,
        limit_type: p1.limit_type
      }
      ]
  [
    mplan1
  ] = MemberPlanSeeder.seed(member_plans_data)
