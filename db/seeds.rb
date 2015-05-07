class Seed
  def initialize
    build_uncontacted_companies
    build_contacted_companies
    build_confirmed_companies
    build_dead_companies
    build_pdf
    build_techhire_locations
    build_pdfs
    build_users
    build_content
  end

  def build_pdf
    pdf = Pdf.create(slot: 1)
    pdf.pdf_file = File.open("public/assets/pdfs/sample_pdf.pdf")
    pdf.save
  end

  def build_techhire_locations
    TechhireLocation.create(
      city: "Louisville",
      state: "Kentucky"
    )

    TechhireLocation.create(
      city: "New York City",
      state: "New York"
    )

    TechhireLocation.create(
      city: "Philadelphia",
      state: "Pennsylvania"
    )

    TechhireLocation.create(
      city: "Louisville",
      state: "Kentucky"
    )

    TechhireLocation.create(
      city: "City of Kearney and Buffalo County",
      state: "Kentucky"
    )

    TechhireLocation.create(
      city: "St. Louis",
      state: "Missouri"
    )

    TechhireLocation.create(
      city: "Salt Lake City",
      state: "Utah"
    )

    TechhireLocation.create(
      city: "San Antonio",
      state: "Texas"
    )

    TechhireLocation.create(
      city: "Los Angeles",
      state: "California"
    )

    TechhireLocation.create(
      city: "Minneapolis",
      state: "Minnesota"
    )

    TechhireLocation.create(
      city: "Kansas City",
      state: "Kansas"
    )

    TechhireLocation.create(
      city: "Memphis",
      state: "Tennessee"
    )

    TechhireLocation.create(
      city: "City of Kearney and Buffalo County",
      state: "Kentucky"
    )

    TechhireLocation.create(
      city: "Eastern Kentucky",
      state: "Kentucky"
    )

    TechhireLocation.create(
      city: "Nashville",
      state: "Tennessee"
    )

    TechhireLocation.create(
      city: "Rochester",
      state: "New York"
    )

    TechhireLocation.create(
      city: "Detroit",
      state: "Michigan"
    )

    TechhireLocation.create(
      city: "City of Kearney and Buffalo County",
      state: "Kentucky"
    )

    TechhireLocation.create(
      city: "San Francisco",
      state: "California"
    )

    TechhireLocation.create(
      city: "Albuquerque",
      state: "New Mexico"
    )

    TechhireLocation.create(
      city: "Chattanooga",
      state: "Tennessee"
    )

    TechhireLocation.create(
      city: "Portland",
      state: "Oregon"
    )

    TechhireLocation.create(
      city: "Dover",
      state: "Delaware"
    )

    TechhireLocation.create(
      city: "Anchorage",
      state: "Alaska"
    )
  end

  #Companies
  def build_uncontacted_companies
    i = 1
    10.times do
      Company.create(
      name: "user#{i}",
      organization: "company#{i}",
      title: "head person#{i}",
      state: "MO",
      city: "St. Louis",
      email: "user#{i}@email.com",
      hiring: 1,
      hire_count: 5,
      status: "uncontacted"
      )
      i = i + 1
    end
  end

  def build_contacted_companies
    i = 11
    10.times do
      Company.create(
        name: "user#{i}",
        organization: "company#{i}",
        title: "head person#{i}",
        state: "CO",
        city: "Denver",
        email: "user#{i}@email.com",
        hiring: 1,
        hire_count: 5,
        status: "contacted")
      i = i + 1
    end
  end

  def build_confirmed_companies
    i = 21
    9.times do
      Company.create(
        name: "user#{i}",
        organization: "company#{i}",
        title: "head person#{i}",
        state: "KS",
        city: "Witchita",
        email: "user#{i}@email.com",
        hiring: 1,
        hire_count: 5,
        status: "confirmed"
      )
      i = i + 1
    end
  end

  def build_dead_companies
    i = 31
    10.times do
      Company.create(
        name: "user#{i}",
        organization: "company#{i}",
        title: "head person#{i}",
        state: "OK",
        city: "Oklahoma City",
        email: "user#{i}@email.com",
        hiring: 1,
        hire_count: 5,
        status: "dead"
      )
      i = i + 1
    end
  end

  # Pdfs
  def build_pdfs
    pdf = Pdf.create(slot: 1)
    pdf.pdf_file = File.open("public/assets/pdfs/sample_pdf.pdf")
    pdf.save
  end

  def build_users
    User.create(email: "admin@gmail.com", password: "password", role: 1)
  end

  def build_content
    3.times do |x|
      Content.create(title: "Some descriptive title",
                      body: "Body of text",
                      page: "learn more",
                      slot: x + 1)
    end

    20.times do
      Content.create(title:Faker::Lorem::sentence(3), body: Faker::Lorem.sentence(3))
    end
  end
end
Seed.new
