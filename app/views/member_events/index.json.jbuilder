# frozen_string_literal: true

json.array!(@member_events, partial: 'member_events/member_event', as: :member_event)
