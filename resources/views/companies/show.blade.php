@extends('layouts.app')
@section('title')
    {{ __('messages.company.company_details') }}
@endsection
@push('css')
    @livewireStyles
    <link rel="stylesheet" href="{{ asset('assets/css/category.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/nano.min.css') }}">
    <link href="{{ asset('assets/css/ticket.css') }}" rel="stylesheet" type="text/css"/>
@endpush
@section('content')
    <section class="section">
        <div class="section-header sm-section-p flex-wrap">
            <h1 class="mr-3">{{ $company->name.' '.__('messages.user.details') }}</h1>
            <div class="section-header-breadcrumb">
                <a href="javascript:void(0)" data-id="{{ $company->id }}"
                   class="btn btn-warning form-btn float-right mr-2 edit-btn">{{ __('messages.company.edit_company') }}</a>
                <a href="{{ route('company.index') }}"
                   class="btn btn-primary form-btn float-right my-sm-0 my-1">{{__('messages.common.back')}}</a>
            </div>
        </div>
        <div class="section-body">
            <div class="card">
                <div class="card-body">
                    @livewire('tickets',['company' => $company])
                </div>
            </div>
            <div id="taskEditModal">
                @include('tickets.edit_assignee_modal')
            </div>
        </div>
        @include('companies.edit_modal')
    </section>
@endsection
@push('scripts')
    <script src="{{ asset('vendor/livewire/livewire.js') }}"></script>
    @include('livewire.livewire-turbo')
    <script>
        let companyUrl = "{{ route('company.index') }}"
        let ticketUrl = '{{ url('admin/tickets') }}/'
        let activeStatus = '{{ \App\Models\Ticket::STATUS_ACTIVE }}'
    </script>
    <script src="{{ asset('assets/js/select2.min.js') }}"></script>
    <script src="{{ asset('assets/js/tickets/tickets.js') }}"></script>
    <script src="{{ asset('assets/js/pickr.min.js') }}"></script>
    <script src="{{ asset('assets/js/companies/show_company.js') }}"></script>
@endpush
