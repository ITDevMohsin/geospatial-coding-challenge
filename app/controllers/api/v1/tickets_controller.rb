class Api::V1::TicketsController < ApplicationController

  def create
    request_body = request.body.read

    if request_body.blank?
      render json: { errors: 'Empty request body' }, status: :bad_request
      return
    end

    begin
      data = JSON.parse(request_body)
      ticket = create_ticket(data)
      create_service_records(data, ticket)
      create_excavator_records(data, ticket)
      create_excavation_info_records(data, ticket)
    rescue JSON::ParserError => e
      render json: { errors: 'Invalid JSON format' }, status: :bad_request
      return
    end

    if ticket.save
      render json: { message: 'Data saved successfully' }, status: :created
    else
      render json: { errors: 'Data not saved successfully' }, status: :unprocessable_entity
    end

  end

  def create_ticket(ticket_data)
    Ticket.create(
      contact_center: ticket_data["ContactCenter"],
      request_number: ticket_data["RequestNumber"],
      reference_request_number: ticket_data["ReferenceRequestNumber"],
      version_number: ticket_data["VersionNumber"],
      sequence_number: ticket_data["SequenceNumber"],
      request_type: ticket_data["RequestType"],
      request_action: ticket_data["RequestAction"],
      request_taken_datetime: parse_datetime(ticket_data["DateTimes"]["RequestTakenDateTime"]),
      transmission_datetime: parse_datetime(ticket_data["DateTimes"]["TransmissionDateTime"]),
      legal_datetime: parse_datetime(ticket_data["DateTimes"]["LegalDateTime"]),
      response_due_datetime: parse_datetime(ticket_data["DateTimes"]["ResponseDueDateTime"]),
      restake_date: parse_datetime(ticket_data["DateTimes"]["RestakeDate"]),
      expiration_date: parse_datetime(ticket_data["DateTimes"]["ExpirationDate"]),
      lp_meeting_accept_due_date: parse_datetime(ticket_data["DateTimes"]["LPMeetingAcceptDueDate"]),
      overhead_begin_date: parse_datetime(ticket_data["DateTimes"]["OverheadBeginDate"]),
      overhead_end_date: parse_datetime(ticket_data["DateTimes"]["OverheadEndDate"])
    )
  end

  def create_service_records(service_data, ticket)
    service_area = ServiceArea.create(
      primary_service_area_code: service_data["ServiceArea"]["PrimaryServiceAreaCode"]["SACode"]
    )
    ticket.service_area = service_area

    additional_service_data = service_data["ServiceArea"]["AdditionalServiceAreaCodes"]["SACode"]
    additional_service_data.each do |sa_code|
      ticket.service_area.additional_service_area_codes.create(sa_code: sa_code)
    end
  end

  def create_excavator_records(data, ticket)
    excavator = Excavator.create(
      company_name: data["Excavator"]["CompanyName"],
      address: data["Excavator"]["Address"],
      city: data["Excavator"]["City"],
      state: data["Excavator"]["State"],
      zip: data["Excavator"]["Zip"],
      type: data["Excavator"]["Type"],
      contact_name: data["Excavator"]["Contact"]["Name"],
      contact_phone: data["Excavator"]["Contact"]["Phone"],
      contact_email: data["Excavator"]["Contact"]["Email"],
      field_contact_name: data["Excavator"]["FieldContact"]["Name"],
      field_contact_phone: data["Excavator"]["FieldContact"]["Phone"],
      field_contact_email: data["Excavator"]["FieldContact"]["Email"],
      crew_onsite: data["Excavator"]["CrewOnsite"].to_s == "true"
    )
    ticket.excavator = excavator
  end

  def create_excavation_info_records(data, ticket)
    excavation_info = ExcavationInfo.create(
      type_of_work: data["ExcavationInfo"]["TypeOfWork"],
      work_done_for: data["ExcavationInfo"]["WorkDoneFor"],
      project_duration: data["ExcavationInfo"]["ProjectDuration"],
      project_start_date: parse_datetime(data["ExcavationInfo"]["ProjectStartDate"]),
      explosives: data["ExcavationInfo"]["Explosives"],
      underground_overhead: data["ExcavationInfo"]["UndergroundOverhead"],
      horizontal_boring: data["ExcavationInfo"]["HorizontalBoring"],
      whitelined: data["ExcavationInfo"]["Whitelined"],
      locate_instructions: data["ExcavationInfo"]["LocateInstructions"],
      remarks: data["ExcavationInfo"]["Remarks"]
    )
    ticket.excavation_info = excavation_info

    digsite_info = DigsiteInfo.create(
      lookup_by: data["ExcavationInfo"]["DigsiteInfo"]["LookupBy"],
      location_type: data["ExcavationInfo"]["DigsiteInfo"]["LocationType"],
      subdivision: data["ExcavationInfo"]["DigsiteInfo"]["Subdivision"],
      address_state: data["ExcavationInfo"]["DigsiteInfo"]["AddressInfo"]["State"],
      address_county: data["ExcavationInfo"]["DigsiteInfo"]["AddressInfo"]["County"],
      address_place: data["ExcavationInfo"]["DigsiteInfo"]["AddressInfo"]["Place"],
      address_zip: data["ExcavationInfo"]["DigsiteInfo"]["AddressInfo"]["Zip"],
      address_num: data["ExcavationInfo"]["DigsiteInfo"]["AddressInfo"]["Address"]["AddressNum"].join(", "),
      address_street_prefix: data["ExcavationInfo"]["DigsiteInfo"]["AddressInfo"]["Street"]["Prefix"],
      address_street_name: data["ExcavationInfo"]["DigsiteInfo"]["AddressInfo"]["Street"]["Name"],
      address_street_type: data["ExcavationInfo"]["DigsiteInfo"]["AddressInfo"]["Street"]["Type"],
      address_street_suffix: data["ExcavationInfo"]["DigsiteInfo"]["AddressInfo"]["Street"]["Suffix"],
      near_street_state: data["ExcavationInfo"]["DigsiteInfo"]["NearStreet"]["State"],
      near_street_county: data["ExcavationInfo"]["DigsiteInfo"]["NearStreet"]["County"],
      near_street_place: data["ExcavationInfo"]["DigsiteInfo"]["NearStreet"]["Place"],
      near_street_prefix: data["ExcavationInfo"]["DigsiteInfo"]["NearStreet"]["Prefix"],
      near_street_name: data["ExcavationInfo"]["DigsiteInfo"]["NearStreet"]["Name"],
      near_street_type: data["ExcavationInfo"]["DigsiteInfo"]["NearStreet"]["Type"],
      near_street_suffix: data["ExcavationInfo"]["DigsiteInfo"]["NearStreet"]["Suffix"]
    )

    excavation_info.digsite_info = digsite_info

    intersection_data = data["ExcavationInfo"]["DigsiteInfo"]["Intersection"]
    if intersection_data.is_a?(Array)
      intersection_data.each do |intersection|
        digsite_info.intersections.create(
          intersection_state: intersection["State"],
          intersection_county: intersection["County"],
          intersection_place: intersection["Place"],
          intersection_prefix: intersection["Prefix"],
          intersection_name: intersection["Name"],
          intersection_type: intersection["Type"],
          intersection_suffix: intersection["Suffix"]
        )
      end
    end

    well_known_text_data = {
      wkt: data["ExcavationInfo"]["DigsiteInfo"]["WellKnownText"]
    }
    digsite_info.build_well_known_text(well_known_text_data).save
  end

  def parse_datetime(datetime_string)
    DateTime.parse(datetime_string) unless datetime_string.blank?
  end
end
