every 1.day, at: '4:30 am' do
    runner "DailyPurchaseReportWorker.perform_async"
end
  